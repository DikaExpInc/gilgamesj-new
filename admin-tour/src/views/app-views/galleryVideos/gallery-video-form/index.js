import React, { useState, useEffect } from 'react'
import PageHeaderAlt from 'components/layout-components/PageHeaderAlt'
import { Tabs, Form, Button, message, Spin } from 'antd'
import Flex from 'components/shared-components/Flex'
import GeneralField from './GeneralField'
import { createGalleryVideo, updateGalleryVideo } from 'redux/actions'
import { useDispatch } from 'react-redux'
import { useHistory } from 'react-router-dom'
import { BASE_URL, colorPrimary } from 'configs/AppConfig'
import moment from 'moment'
import galleryVideoService from 'services/GalleryVideoService'

const { TabPane } = Tabs

const getBase64 = (img, callback) => {
  const reader = new FileReader()
  reader.addEventListener('load', () => callback(reader.result))
  reader.readAsDataURL(img)
}

const ADD = 'ADD'
const EDIT = 'EDIT'

const GalleryVideoForm = (props) => {
  const { mode = ADD, param } = props

  let history = useHistory()
  const [form] = Form.useForm()
  const dispatch = useDispatch()
  const [uploadedImg, setImage] = useState('')
  const [imageOriginal, setImageOriginal] = useState('')
  const [uploadLoading, setUploadLoading] = useState(false)
  const [uploadedVideo, setVideo] = useState('')
  const [videoOriginal, setVideoOriginal] = useState('')
  const [uploadVideoLoading, setUploadVideoLoading] = useState(false)
  const [submitLoading, setSubmitLoading] = useState(false)
  const [loadingData, setLoadingData] = useState(true)
  const [galleryVideoData, setGalleryVideoData] = useState({})

  useEffect(() => {
    if (mode === EDIT) {
      const { id } = param

      galleryVideoService.getGalleryVideo(id).then((querySnapshot) => {
        setGalleryVideoData({ ...querySnapshot.data, _id: id })
        form.setFieldsValue({
          title: querySnapshot.data.title,
          date: moment(querySnapshot.data.date),
        })
        setImage(`${BASE_URL}${querySnapshot.data.thumbnail}`)
        setVideo(`${BASE_URL}${querySnapshot.data.video}`)
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

  const handleUploadVideoChange = (info) => {
    const isMp4MpegWebm =
      info.file.type === 'video/mp4' ||
      info.file.type === 'video/mpeg' ||
      info.file.type === 'video/webm'
    if (!isMp4MpegWebm) {
      message.error('You can only upload MP4/MPEG/WEBM file!')
      return
    }

    const isLt50M = info.file.size / 1024 / 1024 < 50
    if (!isLt50M) {
      message.error('Video must be smaller than 50MB!')
      return
    }

    setVideoOriginal(info.file)
    getBase64(info.file.originFileObj, (imageUrl) => {
      setVideo(imageUrl)
      setUploadVideoLoading(true)
    })
  }

  const onFinish = async () => {
    setSubmitLoading(true)
    try {
      const values = await form.validateFields()
      const formData = new FormData()

      if (mode === ADD) {
        formData.append('thumbnail', imageOriginal.originFileObj)
        formData.append('video', videoOriginal.originFileObj)
        for (const key in values) {
          formData.append(key, values[key])
        }
        const resp = await galleryVideoService.addGalleryVideo(formData)
        dispatch(createGalleryVideo(resp.data)) // Assuming the API returns the created news data
        message.success(`Create gallery video with title '${values.title}'`)
        history.push(`/app/gallery-videos`)
      } else if (mode === EDIT) {
        formData.append('thumbnail', imageOriginal.originFileObj)
        formData.append('video', videoOriginal.originFileObj)
        for (const key in values) {
          formData.append(key, values[key])
        }
        const resp = await galleryVideoService.updateGalleryVideo(
          galleryVideoData._id,
          formData
        )
        dispatch(updateGalleryVideo(resp.data)) // Assuming the API returns the updated news data
        message.success(
          `Gallery video with title '${values.title}' has updated`
        )
        history.push(`/app/gallery-videos`)
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
                {mode === 'ADD' ? 'Add Gallery Video' : `Edit Gallery Video`}{' '}
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
                  uploadedVideo={uploadedVideo}
                  uploadVideoLoading={uploadVideoLoading}
                  handleUploadVideoChange={handleUploadVideoChange}
                />
              )}
            </TabPane>
          </Tabs>
        </div>
      </Form>
    </>
  )
}

export default GalleryVideoForm
