import React, { useState, useEffect } from 'react'
import PageHeaderAlt from 'components/layout-components/PageHeaderAlt'
import { Tabs, Form, Button, message, Spin } from 'antd'
import Flex from 'components/shared-components/Flex'
import GeneralField from './GeneralField'
import { createChat, updateChat } from 'redux/actions'
import { useDispatch } from 'react-redux'
import { useHistory } from 'react-router-dom'
import { BASE_URL, colorPrimary } from 'configs/AppConfig'
import chatService from 'services/ChatService'

const { TabPane } = Tabs

const getBase64 = (img, callback) => {
  const reader = new FileReader()
  reader.addEventListener('load', () => callback(reader.result))
  reader.readAsDataURL(img)
}

const ADD = 'ADD'
const EDIT = 'EDIT'

const ChatForm = (props) => {
  const { mode = ADD, param } = props

  let history = useHistory()
  const [form] = Form.useForm()
  const dispatch = useDispatch()
  const [uploadedImg, setImage] = useState('')
  const [imageOriginal, setImageOriginal] = useState('')
  const [uploadLoading, setUploadLoading] = useState(false)
  const [submitLoading, setSubmitLoading] = useState(false)
  const [loadingData, setLoadingData] = useState(true)
  const [chatData, setChatData] = useState({})

  useEffect(() => {
    if (mode === EDIT) {
      const { id } = param
      chatService.getChat(id).then((querySnapshot) => {
        setChatData({ ...querySnapshot.data, _id: id })
        form.setFieldsValue({
          name: querySnapshot.data.name,
          contact_number: querySnapshot.data.contact_number,
          profile: querySnapshot.data.profile,
        })
        setImage(`${BASE_URL}${querySnapshot.data.profile}`)
        setLoadingData(false)
      })
    } else {
      setLoadingData(false)
    }
  }, [form, mode, param, props])

  const handleUploadChange = (info) => {
    setImageOriginal(info.file)
    getBase64(info.file.originFileObj, (imageUrl) => {
      setImage(imageUrl)
      setUploadLoading(true)
    })
  }

  const onFinish = async () => {
    setSubmitLoading(true)
    try {
      const values = await form.validateFields()
      const formData = new FormData()

      if (mode === ADD) {
        formData.append('profile', imageOriginal.originFileObj)
        for (const key in values) {
          formData.append(key, values[key])
        }

        const resp = await chatService.addChat(formData)
        dispatch(createChat(resp.data)) // Assuming the API returns the created news data
        message.success(`Create chat with name '${values.name}'`)
        history.push(`/app/chats`)
      } else if (mode === EDIT) {
        formData.append('profile', imageOriginal.originFileObj)
        for (const key in values) {
          formData.append(key, values[key])
        }

        const resp = await chatService.updateChat(chatData._id, formData)
        dispatch(updateChat(resp.data)) // Assuming the API returns the updated news data
        message.success(`Chat with name '${values.title}' has updated`)
        history.push(`/app/chats`)
      }
    } catch (error) {
      setSubmitLoading(false)
      console.log('Error:', error)
      message.error('An error occurred. Please try again later.')
    }
  }

  const onDiscard = () => {
    history.goBack()
  }

  return (
    <>
      <Form
        layout="vertical"
        form={form}
        name="advanced_search"
        className="ant-advanced-search-form"
        initialValues={{
          heightUnit: 'cm',
          widthUnit: 'cm',
          weightUnit: 'kg',
        }}
      >
        <PageHeaderAlt className="border-bottom" overlap>
          <div className="container">
            <Flex
              className="py-2"
              mobileFlex={false}
              justifyContent="between"
              alignItems="center"
            >
              <h2 className="mb-3">
                {mode === 'ADD' ? 'Add Chat' : `Edit Chat`}{' '}
              </h2>
              <div className="mb-3">
                <Button className="mr-2" onClick={() => onDiscard()}>
                  Cancel
                </Button>
                <Button
                  style={{
                    backgroundColor: colorPrimary,
                    color: 'white',
                    border: 'none',
                  }}
                  onClick={() => onFinish()}
                  htmlType="submit"
                  loading={submitLoading}
                >
                  {mode === 'ADD' ? 'Add' : `Save`}
                </Button>
              </div>
            </Flex>
          </div>
        </PageHeaderAlt>
        <div className="container">
          <Tabs defaultActiveKey="1" style={{ marginTop: 30 }}>
            <TabPane tab="General" key="1">
              {loadingData && <Spin size="large" tip="Please Wait" />}
              {!loadingData && (
                <GeneralField
                  uploadedImg={uploadedImg}
                  uploadLoading={uploadLoading}
                  handleUploadChange={handleUploadChange}
                />
              )}
            </TabPane>
          </Tabs>
        </div>
      </Form>
    </>
  )
}

export default ChatForm
