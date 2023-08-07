import React, { useState, useEffect } from 'react'
import PageHeaderAlt from 'components/layout-components/PageHeaderAlt'
import { Tabs, Form, Button, message, Spin } from 'antd'
import Flex from 'components/shared-components/Flex'
import GeneralField from './GeneralField'
import { createPhone, updatePhone } from 'redux/actions'
import { useDispatch } from 'react-redux'
import { useHistory } from 'react-router-dom'
import { BASE_URL, colorPrimary } from 'configs/AppConfig'
import phoneService from 'services/PhoneService'

const { TabPane } = Tabs

const getBase64 = (img, callback) => {
  const reader = new FileReader()
  reader.addEventListener('load', () => callback(reader.result))
  reader.readAsDataURL(img)
}

const ADD = 'ADD'
const EDIT = 'EDIT'

const PhoneForm = (props) => {
  const { mode = ADD, param } = props

  let history = useHistory()
  const [form] = Form.useForm()
  const dispatch = useDispatch()
  const [uploadedImg, setImage] = useState('')
  const [imageOriginal, setImageOriginal] = useState('')
  const [uploadLoading, setUploadLoading] = useState(false)
  const [uploadedAudio, setAudio] = useState('')
  const [audioOriginal, setAudioOriginal] = useState('')
  const [uploadAudioLoading, setUploadAudioLoading] = useState(false)
  const [submitLoading, setSubmitLoading] = useState(false)
  const [loadingData, setLoadingData] = useState(true)
  const [phoneData, setPhoneData] = useState({})

  useEffect(() => {
    if (mode === EDIT) {
      const { id } = param
      phoneService.getPhone(id).then((querySnapshot) => {
        setPhoneData({ ...querySnapshot.data, _id: id })
        form.setFieldsValue({
          name: querySnapshot.data.name,
          phone_number: querySnapshot.data.phone_number,
        })
        setImage(`${BASE_URL}${querySnapshot.data.profile}`)
        setAudio(`${BASE_URL}${querySnapshot.data.audio}`)
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

  const handleUploadAudioChange = (info) => {
    const isMp3OrWav =
      info.file.type === 'audio/mp3' ||
      info.file.type === 'audio/mpeg' ||
      info.file.type === 'audio/wav'
    if (!isMp3OrWav) {
      message.error('You can only upload MP3/WAV file!')
      return
    }

    const isLt10M = info.file.size / 1024 / 1024 < 10
    if (!isLt10M) {
      message.error('Audio must be smaller than 10MB!')
      return
    }

    setAudioOriginal(info.file)
    getBase64(info.file.originFileObj, (audioUrl) => {
      setAudio(audioUrl)
      setUploadAudioLoading(true)
    })
  }

  const onFinish = async () => {
    setSubmitLoading(true)
    setSubmitLoading(true)
    try {
      const values = await form.validateFields()
      const formData = new FormData()

      if (mode === ADD) {
        formData.append('profile', imageOriginal.originFileObj)
        formData.append('audio', audioOriginal.originFileObj)
        for (const key in values) {
          formData.append(key, values[key])
        }

        const resp = await phoneService.addPhone(formData)
        dispatch(createPhone(resp.data)) // Assuming the API returns the created news data
        message.success(`Create phone with name '${values.name}'`)
        history.push(`/app/phones`)
      } else if (mode === EDIT) {
        formData.append('profile', imageOriginal.originFileObj)
        formData.append('audio', audioOriginal.originFileObj)
        for (const key in values) {
          formData.append(key, values[key])
        }

        const resp = await phoneService.updatePhone(phoneData._id, formData)
        dispatch(updatePhone(resp.data)) // Assuming the API returns the updated news data
        message.success(`Phone with name '${values.name}' has updated`)
        history.push(`/app/phones`)
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
                {mode === 'ADD' ? 'Add Phone' : `Edit Phone`}{' '}
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
                  uploadedAudio={uploadedAudio}
                  uploadAudioLoading={uploadAudioLoading}
                  handleUploadAudioChange={handleUploadAudioChange}
                />
              )}
            </TabPane>
          </Tabs>
        </div>
      </Form>
    </>
  )
}

export default PhoneForm
