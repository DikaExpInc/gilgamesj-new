import React, { useState, useEffect } from 'react'
import PageHeaderAlt from 'components/layout-components/PageHeaderAlt'
import { Tabs, Form, Button, message, Spin } from 'antd'
import Flex from 'components/shared-components/Flex'
import GeneralField from './GeneralField'
import {
  createSocialMediaComment,
  updateSocialMediaComment,
} from 'redux/actions'
import { useDispatch } from 'react-redux'
import { useHistory } from 'react-router-dom'
import { BASE_URL, colorPrimary } from 'configs/AppConfig'
import { useParams } from 'react-router-dom/cjs/react-router-dom.min'
import socialMediaCommentService from 'services/SocialMediaCommentService'

const { TabPane } = Tabs

const getBase64 = (img, callback) => {
  const reader = new FileReader()
  reader.addEventListener('load', () => callback(reader.result))
  reader.readAsDataURL(img)
}

const ADD = 'ADD'
const EDIT = 'EDIT'

const SocialMediaCommentForm = (props) => {
  const { mode = ADD, param } = props

  let history = useHistory()
  const { socialMediaId } = useParams()
  const [form] = Form.useForm()
  const dispatch = useDispatch()
  const [uploadedProfileImg, setProfileImage] = useState('')
  const [profileImageOriginal, setProfileImageOriginal] = useState('')
  const [profileUploadLoading, setProfileUploadLoading] = useState(false)
  const [submitLoading, setSubmitLoading] = useState(false)
  const [loadingData, setLoadingData] = useState(true)
  const [SocialMediaCommentData, setSocialMediaCommentData] = useState({})

  useEffect(() => {
    if (mode === EDIT) {
      const { id } = param
      socialMediaCommentService
        .getSocialMedia(socialMediaId, id)
        .then((querySnapshot) => {
          setSocialMediaCommentData({
            ...querySnapshot.data,
            _id: id,
          })
          form.setFieldsValue({
            name: querySnapshot.data.name,
            comment: querySnapshot.data.comment,
            location: querySnapshot.data.location,
          })
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

  const onFinish = async () => {
    setSubmitLoading(true)
    try {
      const values = await form.validateFields()
      const formData = new FormData()

      if (mode === ADD) {
        formData.append('profile', profileImageOriginal.originFileObj)
        for (const key in values) {
          formData.append(key, values[key])
        }
        const resp = await socialMediaCommentService.addSocialMedia(
          socialMediaId,
          formData
        )
        dispatch(createSocialMediaComment(resp.data)) // Assuming the API returns the created news data
        message.success(`Create social media '${values.name}' success`)
        history.push(`/app/social-medias/comment/${socialMediaId}`)
      } else if (mode === EDIT) {
        formData.append('profile', profileImageOriginal.originFileObj)
        for (const key in values) {
          formData.append(key, values[key])
        }
        const resp = await socialMediaCommentService.updateSocialMedia(
          socialMediaId,
          SocialMediaCommentData._id,
          formData
        )
        dispatch(updateSocialMediaComment(resp.data)) // Assuming the API returns the updated news data
        message.success(`Social Media '${values.title}' has updated`)
        history.push(`/app/social-medias/comment/${socialMediaId}`)
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
                {mode === 'ADD' ? 'Add Comment' : `Edit Comment`}{' '}
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
                  uploadedImg={uploadedProfileImg}
                  uploadLoading={profileUploadLoading}
                  handleUploadChange={handleUploadProfileChange}
                />
              )}
            </TabPane>
          </Tabs>
        </div>
      </Form>
    </>
  )
}

export default SocialMediaCommentForm
