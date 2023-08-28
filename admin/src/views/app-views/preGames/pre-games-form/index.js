import React, { useState, useEffect } from 'react'
import PageHeaderAlt from 'components/layout-components/PageHeaderAlt'
import { Tabs, Form, Button, message, Spin } from 'antd'
import Flex from 'components/shared-components/Flex'
import GeneralField from './GeneralField'
import { createPreGame, updatePreGame } from 'redux/actions'
import { useDispatch } from 'react-redux'
import { useHistory } from 'react-router-dom'
import { BASE_URL, colorPrimary } from 'configs/AppConfig'
import preGameService from 'services/PreGameService'

const { TabPane } = Tabs

const getBase64 = (img, callback) => {
  const reader = new FileReader()
  reader.addEventListener('load', () => callback(reader.result))
  reader.readAsDataURL(img)
}

const ADD = 'ADD'
const EDIT = 'EDIT'

const PreGamesForm = (props) => {
  const { mode = ADD, param } = props

  let history = useHistory()
  const [form] = Form.useForm()
  const dispatch = useDispatch()
  const [uploadedImg, setImage] = useState('')
  const [imageOriginal, setImageOriginal] = useState('')
  const [uploadLoading, setUploadLoading] = useState(false)
  const [submitLoading, setSubmitLoading] = useState(false)
  const [loadingData, setLoadingData] = useState(true)
  const [mapData, setPreGameData] = useState({})

  const [selectValues, setSelectValues] = useState({
    chat_selected: '',
    camera_selected: '',
    mode_selected: '',
  })

  useEffect(() => {
    if (mode === EDIT) {
      const { id } = param
      preGameService.getPreGame(id).then((querySnapshot) => {
        setPreGameData({ ...querySnapshot.data, _id: id })
        form.setFieldsValue({
          title: querySnapshot.data.title,
          description: querySnapshot.data.description,
          order_number: querySnapshot.data.order_number,
        })
        setImage(`${BASE_URL}${querySnapshot.data.image}`)
        setLoadingData(false)
      })
    } else {
      setLoadingData(false)
    }
  }, [form, mode, param, props])

  const handleUploadChange = (info) => {
    const isJpgOrPng =
      info.file.type === 'image/jpeg' || info.file.type === 'image/png'
    if (!isJpgOrPng) {
      message.error('You can only upload JPG/PNG file!')
      return
    }

    const isLt2M = info.file.size / 1024 / 1024 < 2
    if (!isLt2M) {
      message.error('Image must be smaller than 2MB!')
      return
    }

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
        formData.append('icon', imageOriginal.originFileObj)
        // formData.append('chat_id', selectValues.chat_selected)
        // formData.append('camera_id', selectValues.camera_selected)
        for (const key in values) {
          formData.append(key, values[key])
        }
        // for (var pair of formData.entries()) {
        //   console.log(pair[0] + ', ' + pair[1])
        // }
        const resp = await preGameService.addPreGame(formData)
        dispatch(createPreGame(resp.data)) // Assuming the API returns the created news data
        message.success(`Create pre games with title '${values.title}'`)
        history.push(`/app/pre-games`)
      } else if (mode === EDIT) {
        formData.append('icon', imageOriginal.originFileObj)
        formData.append('mode', selectValues.mode_selected)
        formData.append('chat_id', selectValues.chat_selected)
        formData.append('camera_id', selectValues.camera_selected)
        for (const key in values) {
          formData.append(key, values[key])
        }
        const resp = await preGameService.updatePreGame(mapData._id, formData)
        dispatch(updatePreGame(resp.data)) // Assuming the API returns the updated news data
        message.success(`Pre games with title '${values.title}' has updated`)
        history.push(`/app/pre-games`)
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
                {mode === 'ADD' ? 'Add Pre Games' : `Edit Pre Games`}{' '}
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
                  setSelectValues={setSelectValues}
                  selectValues={selectValues}
                />
              )}
            </TabPane>
          </Tabs>
        </div>
      </Form>
    </>
  )
}

export default PreGamesForm
