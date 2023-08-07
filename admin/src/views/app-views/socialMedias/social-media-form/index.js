import React, { useState, useEffect } from 'react'
import PageHeaderAlt from 'components/layout-components/PageHeaderAlt'
import { Tabs, Form, Button, message, Spin } from 'antd'
import Flex from 'components/shared-components/Flex'
import GeneralField from './GeneralField'
import { createSocialMedia, updateSocialMedia } from 'redux/actions'
import { useDispatch } from 'react-redux'
import { useHistory } from 'react-router-dom'
import { BASE_URL, colorPrimary } from 'configs/AppConfig'
import moment from 'moment'
import socialMediaService from 'services/SocialMediaService'

const { TabPane } = Tabs

const getBase64 = (img, callback) => {
  const reader = new FileReader()
  reader.addEventListener('load', () => callback(reader.result))
  reader.readAsDataURL(img)
}

const ADD = 'ADD'
const EDIT = 'EDIT'

const SocialMediasForm = (props) => {
  const { mode = ADD, param } = props

  let history = useHistory()
  const [form] = Form.useForm()
  const dispatch = useDispatch()

  const [uploadedProfileImg, setProfileImage] = useState('')
  const [uploadedImg, setImage] = useState('')

  const [profileImageOriginal, setProfileImageOriginal] = useState('')
  const [imageOriginal, setImageOriginal] = useState('')

  const [profileUploadLoading, setProfileUploadLoading] = useState(false)
  const [uploadLoading, setUploadLoading] = useState(false)
  const [submitLoading, setSubmitLoading] = useState(false)
  const [loadingData, setLoadingData] = useState(true)
  const [socialMediasData, setSocialMediasData] = useState({})

  useEffect(() => {
    if (mode === EDIT) {
      const { id } = param

      socialMediaService.getSocialMedia(id).then((querySnapshot) => {
        setSocialMediasData({
          ...querySnapshot.data,
          _id: id,
        })
        form.setFieldsValue({
          name: querySnapshot.data.name,
          description: querySnapshot.data.description,
          location: querySnapshot.data.location,
          date: moment(querySnapshot.data.date, 'YYYY-MM-DD'),
        })
        setImage(`${BASE_URL}${querySnapshot.data.post_image}`)
        setProfileImage(`${BASE_URL}${querySnapshot.data.profile}`)
        setLoadingData(false)
      })
    } else {
      setLoadingData(false)
    }
  }, [form, mode, param, props])

  const handleUploadProfileChange = (info) => {
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

    setProfileImageOriginal(info.file)
    getBase64(info.file.originFileObj, (imageUrl) => {
      setProfileImage(imageUrl)
      setProfileUploadLoading(true)
    })
  }

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
        formData.append('profile', profileImageOriginal.originFileObj)
        formData.append('post_image', imageOriginal.originFileObj)
        for (const key in values) {
          formData.append(key, values[key])
        }
        const resp = await socialMediaService.addSocialMedia(formData)
        dispatch(createSocialMedia(resp.data)) // Assuming the API returns the created news data
        message.success(`Create social media '${values.name}' success`)
        history.push(`/app/social-medias`)
      } else if (mode === EDIT) {
        formData.append('profile', profileImageOriginal.originFileObj)
        formData.append('post_image', imageOriginal.originFileObj)
        for (const key in values) {
          formData.append(key, values[key])
        }
        const resp = await socialMediaService.updateSocialMedia(
          socialMediasData._id,
          formData
        )
        dispatch(updateSocialMedia(resp.data)) // Assuming the API returns the updated news data
        message.success(`Social Media '${values.title}' has updated`)
        history.push(`/app/social-medias`)
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
                {mode === 'ADD' ? 'Add Social Medias' : `Edit Social Medias`}{' '}
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
                  profileUploadImg={uploadedProfileImg}
                  profileUploadLoading={profileUploadLoading}
                  handleUploadChange={handleUploadChange}
                  handleUploadProfileChange={handleUploadProfileChange}
                />
              )}
            </TabPane>
          </Tabs>
        </div>
      </Form>
    </>
  )
}

export default SocialMediasForm
