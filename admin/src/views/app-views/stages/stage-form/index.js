import React, { useState, useEffect } from 'react'
import PageHeaderAlt from 'components/layout-components/PageHeaderAlt'
import { Tabs, Form, Button, message, Spin } from 'antd'
import Flex from 'components/shared-components/Flex'
import GeneralField from './GeneralField'
import { createStage, updateStage } from 'redux/actions'
import { useDispatch } from 'react-redux'
import { useHistory } from 'react-router-dom'
import { BASE_URL, colorPrimary } from 'configs/AppConfig'
import stageService from 'services/StageService'

const { TabPane } = Tabs

const getBase64 = (img, callback) => {
  const reader = new FileReader()
  reader.addEventListener('load', () => callback(reader.result))
  reader.readAsDataURL(img)
}

const ADD = 'ADD'
const EDIT = 'EDIT'

const StageForm = (props) => {
  const { mode = ADD, param } = props

  let history = useHistory()
  const [form] = Form.useForm()
  const dispatch = useDispatch()

  const [uploadedObjective, setObjective] = useState('')
  const [objectiveOriginal, setObjectiveOriginal] = useState('')
  const [uploadObjectiveLoading, setUploadObjectiveLoading] = useState(false)

  const [uploadedBackground, setBackground] = useState('')
  const [backgroundOriginal, setBackgroundOriginal] = useState('')
  const [uploadBackgroundLoading, setUploadBackgroundLoading] = useState(false)

  const [uploadedModel, setModel] = useState('')
  const [modelOriginal, setModelOriginal] = useState('')
  const [uploadModelLoading, setUploadModelLoading] = useState(false)

  const [submitLoading, setSubmitLoading] = useState(false)
  const [loadingData, setLoadingData] = useState(true)
  const [stageData, setStageData] = useState({})

  const [status_stage, setStatus_stage] = useState(true)

  const [social_media_list, setSocial_media_list] = useState([])
  const [gallery_photo_list, setGallery_photo_list] = useState([])
  const [gallery_video_list, setGallery_video_list] = useState([])
  const [map_list, setMap_list] = useState([])
  const [chat_list, setChat_list] = useState([])
  const [camera_list, setCamera_list] = useState([])
  const [phone_list, setPhone_list] = useState([])
  const [contact_list, setContact_list] = useState([])
  const [news_browser_list, setNews_browser_list] = useState([])

  const [selectValues, setSelectValues] = useState({
    social_media_selected: [],
    gallery_photo_selected: [],
    gallery_video_selected: [],
    map_selected: [],
    chat_selected: [],
    camera_selected: [],
    phone_selected: [],
    contact_selected: [],
    browser_selected: [],
  })

  useEffect(() => {
    if (mode === EDIT) {
      const { id } = param
      stageService.getStage(id).then((querySnapshot) => {
        setStageData({ ...querySnapshot.data, _id: id })
        form.setFieldsValue({
          title: querySnapshot.data.title,
          description: querySnapshot.data.description,
          order_number: querySnapshot.data.order_number,
          total_player: querySnapshot.data.total_player,
          user_joined: querySnapshot.data.user_joined,
          lock_code: querySnapshot.data.lock_code,
          timer: querySnapshot.data.timer,
        })
        // set List Data Selected
        setSocial_media_list(querySnapshot.data.data_game.social_media)
        setGallery_photo_list(querySnapshot.data.data_game.gallery_photo)
        setGallery_video_list(querySnapshot.data.data_game.gallery_video)
        setMap_list(querySnapshot.data.data_game.map)
        setChat_list(querySnapshot.data.data_game.chat)
        setCamera_list(querySnapshot.data.data_game.camera)
        setPhone_list(querySnapshot.data.data_game.phone)
        setContact_list(querySnapshot.data.data_game.contact)
        setNews_browser_list(querySnapshot.data.data_game.news)

        setSelectValues((prevValues) => ({
          ...prevValues,
          social_media_selected: querySnapshot.data.data_game.social_media,
          gallery_photo_selected: querySnapshot.data.data_game.gallery_photo,
          gallery_video_selected: querySnapshot.data.data_game.gallery_video,
          map_selected: querySnapshot.data.data_game.map,
          chat_selected: querySnapshot.data.data_game.chat,
          camera_selected: querySnapshot.data.data_game.camera,
          phone_selected: querySnapshot.data.data_game.phone,
          contact_selected: querySnapshot.data.data_game.contact,
          browser_selected: querySnapshot.data.data_game.news,
        }))

        setObjective(`${BASE_URL}${querySnapshot.data.objective}`)
        setBackground(`${BASE_URL}${querySnapshot.data.background}`)
        setModel(`${BASE_URL}${querySnapshot.data.model}`)
        setLoadingData(false)
      })
    } else {
      setLoadingData(false)
    }
  }, [form, mode, param, props])

  const handleUploadObjectiveChange = (info) => {
    const isJpgOrPng =
      info.file.type === 'image/jpeg' || info.file.type === 'image/png'
    if (!isJpgOrPng) {
      message.error('You can only upload JPG/PNG file!')
      return
    }

    const isLt2M = info.file.size / 1024 / 1024 < 2
    if (!isLt2M) {
      message.error('Objective must be smaller than 2MB!')
      return
    }

    setObjectiveOriginal(info.file)
    getBase64(info.file.originFileObj, (imageUrl) => {
      setObjective(imageUrl)
      setUploadObjectiveLoading(true)
    })
  }

  const handleUploadBackgroundChange = (info) => {
    const isJpgOrPng =
      info.file.type === 'image/jpeg' || info.file.type === 'image/png'
    if (!isJpgOrPng) {
      message.error('You can only upload JPG/PNG file!')
      return
    }

    const isLt2M = info.file.size / 1024 / 1024 < 2
    if (!isLt2M) {
      message.error('Background must be smaller than 2MB!')
      return
    }

    setBackgroundOriginal(info.file)
    getBase64(info.file.originFileObj, (imageUrl) => {
      setBackground(imageUrl)
      setUploadBackgroundLoading(true)
    })
  }

  const handleUploadModelChange = (info) => {
    console.log(info)
    const isGltfOrGlb =
      info.file.type === 'model/gltf-binary' ||
      info.file.type === 'model/gltf+json' ||
      info.file.name.endsWith('.glb')
    if (!isGltfOrGlb) {
      message.error('You can only upload gltf/glb file!')
      return
    }

    const isLt2M = info.file.size / 1024 / 1024 < 2
    if (!isLt2M) {
      message.error('Model must be smaller than 2MB!')
      return
    }

    setModelOriginal(info.file)
    getBase64(info.file.originFileObj, (modelUrl) => {
      setModel(modelUrl)
      setUploadModelLoading(true)
    })
  }

  const onFinish = async () => {
    setSubmitLoading(true)
    try {
      const values = await form.validateFields()
      const formData = new FormData()

      if (mode === ADD) {
        const data_game = {
          social_media: selectValues.social_media_selected,
          gallery_photo: selectValues.gallery_photo_selected,
          gallery_video: selectValues.gallery_video_selected,
          map: selectValues.map_selected,
          chat: selectValues.chat_selected,
          camera: selectValues.camera_selected,
          phone: selectValues.phone_selected,
          contact: selectValues.contact_selected,
          news: selectValues.browser_selected,
        }

        formData.append('background', backgroundOriginal.originFileObj)
        formData.append('objective', objectiveOriginal.originFileObj)
        formData.append('model', modelOriginal.originFileObj)

        for (const key in values) {
          formData.append(key, values[key])
        }

        // Append each property of the data_game object to formData
        for (const key in data_game) {
          formData.append(`data_game[${key}]`, data_game[key])
        }

        const resp = await stageService.addStage(formData)
        dispatch(createStage(resp.data)) // Assuming the API returns the created news data
        message.success(`Create stage with title '${values.title}'`)
        history.push(`/app/stages`)
      } else if (mode === EDIT) {
        const data_game = {
          social_media: selectValues.social_media_selected,
          gallery_photo: selectValues.gallery_photo_selected,
          gallery_video: selectValues.gallery_video_selected,
          map: selectValues.map_selected,
          chat: selectValues.chat_selected,
          camera: selectValues.camera_selected,
          phone: selectValues.phone_selected,
          contact: selectValues.contact_selected,
          news: selectValues.browser_selected,
        }

        formData.append('background', backgroundOriginal.originFileObj)
        formData.append('objective', objectiveOriginal.originFileObj)
        formData.append('model', modelOriginal.originFileObj)

        console.log(modelOriginal.originFileObj)

        for (const key in values) {
          formData.append(key, values[key])
        }

        // Append each property of the data_game object to formData
        for (const key in data_game) {
          formData.append(`data_game[${key}]`, data_game[key])
        }

        const resp = await stageService.updateStage(stageData._id, formData)
        dispatch(updateStage(resp.data)) // Assuming the API returns the updated news data
        message.success(`Stage with title '${values.title}' has updated`)
        history.push(`/app/stages`)
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
          status: status_stage,
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
                {mode === 'ADD' ? 'Add Stage' : `Edit Stage`}{' '}
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
                  uploadedObjective={uploadedObjective}
                  uploadObjectiveLoading={uploadObjectiveLoading}
                  handleUploadChange={handleUploadObjectiveChange}
                  uploadedModel={uploadedModel}
                  uploadModelLoading={uploadModelLoading}
                  handleUploadModelChange={handleUploadModelChange}
                  uploadedBackground={uploadedBackground}
                  uploadBackgroundLoading={uploadBackgroundLoading}
                  handleUploadBackgroundChange={handleUploadBackgroundChange}
                  social_media_list={social_media_list}
                  gallery_photo_list={gallery_photo_list}
                  gallery_video_list={gallery_video_list}
                  map_list={map_list}
                  chat_list={chat_list}
                  camera_list={camera_list}
                  phone_list={phone_list}
                  contact_list={contact_list}
                  news_browser_list={news_browser_list}
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

export default StageForm
