import React, { useState, useEffect } from 'react'
import PageHeaderAlt from 'components/layout-components/PageHeaderAlt'
import { Tabs, Form, Button, message, Spin } from 'antd'
import Flex from 'components/shared-components/Flex'
import GeneralField from './GeneralField'
import { createStage, updateStage } from 'redux/actions'
import { useDispatch } from 'react-redux'
import { useHistory } from 'react-router-dom'
import { colorPrimary } from 'configs/AppConfig'
import moment from 'moment'

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
  const [uploadedImg, setImage] = useState('')
  const [imageOriginal, setImageOriginal] = useState('')
  const [uploadLoading, setUploadLoading] = useState(false)

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
      // FirebaseService.getStageDetail(id).then((querySnapshot) => {
      //   setStageData({ ...querySnapshot.data(), id: querySnapshot.id })
      //   form.setFieldsValue({
      //     title: querySnapshot.data().title,
      //     description: querySnapshot.data().description,
      //     order_number: querySnapshot.data().order_number,
      //     total_user: querySnapshot.data().total_user,
      //     user_joined: querySnapshot.data().user_joined,
      //     lock_code: querySnapshot.data().lock_code,
      //     timer: querySnapshot.data().timer,
      //   })

      //   setStatus_stage(querySnapshot.data().status)

      //   // set List Data Selected
      //   setSocial_media_list(querySnapshot.data().data_game.social_media)
      //   setGallery_photo_list(querySnapshot.data().data_game.gallery_photo)
      //   setGallery_video_list(querySnapshot.data().data_game.gallery_video)
      //   setMap_list(querySnapshot.data().data_game.map)
      //   setChat_list(querySnapshot.data().data_game.chat)
      //   setCamera_list(querySnapshot.data().data_game.camera)
      //   setPhone_list(querySnapshot.data().data_game.phone)
      //   setContact_list(querySnapshot.data().data_game.contact)
      //   setNews_browser_list(querySnapshot.data().data_game.news)

      //   setSelectValues((prevValues) => ({
      //     ...prevValues,
      //     social_media_selected: querySnapshot.data().data_game.social_media,
      //     gallery_photo_selected: querySnapshot.data().data_game.gallery_photo,
      //     gallery_video_selected: querySnapshot.data().data_game.gallery_video,
      //     map_selected: querySnapshot.data().data_game.map,
      //     chat_selected: querySnapshot.data().data_game.chat,
      //     camera_selected: querySnapshot.data().data_game.camera,
      //     phone_selected: querySnapshot.data().data_game.phone,
      //     contact_selected: querySnapshot.data().data_game.contact,
      //     browser_selected: querySnapshot.data().data_game.news,
      //   }))

      //   setImage(querySnapshot.data().imageUrl)
      //   setBackground(querySnapshot.data().backgroundUrl)
      //   setModel(querySnapshot.data().modelUrl)
      //   setLoadingData(false)
      // })
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

  const handleUploadBackgroundChange = (info) => {
    setBackgroundOriginal(info.file)
    getBase64(info.file.originFileObj, (imageUrl) => {
      setBackground(imageUrl)
      setUploadBackgroundLoading(true)
    })
  }

  const handleUploadModelChange = (info) => {
    setModelOriginal(info.file)
    getBase64(info.file.originFileObj, (modelUrl) => {
      setModel(modelUrl)
      setUploadModelLoading(true)
    })
  }

  const onFinish = () => {
    setSubmitLoading(true)
    // form
    //   .validateFields()
    //   .then((values) => {
    //     setTimeout(async () => {
    //       if (mode === ADD) {
    //         const fileName = `images/stages/${Date.now()}-${imageOriginal.name}`
    //         const fileRef = storage.ref().child(fileName)

    //         const backgroundName = `images/stages/${Date.now()}-${
    //           backgroundOriginal.name
    //         }`
    //         const backgroundRef = storage.ref().child(backgroundName)

    //         const modelName = `models/stages/${Date.now()}-${
    //           modelOriginal.name
    //         }`
    //         const modelRef = storage.ref().child(modelName)
    //         try {
    //           const designFile = await fileRef.put(imageOriginal.originFileObj)
    //           const imageUrl = await designFile.ref.getDownloadURL()
    //           const modelFile = await modelRef.put(modelOriginal.originFileObj)
    //           const modelUrl = await modelFile.ref.getDownloadURL()
    //           const backgroundFile = await backgroundRef.put(
    //             backgroundOriginal.originFileObj
    //           )
    //           const backgroundUrl = await backgroundFile.ref.getDownloadURL()

    //           FirebaseService.addStage({
    //             data_game: {
    //               social_media: selectValues.social_media_selected,
    //               gallery_photo: selectValues.gallery_photo_selected,
    //               gallery_video: selectValues.gallery_video_selected,
    //               map: selectValues.map_selected,
    //               chat: selectValues.chat_selected,
    //               camera: selectValues.camera_selected,
    //               phone: selectValues.phone_selected,
    //               contact: selectValues.contact_selected,
    //               news: selectValues.browser_selected,
    //             },
    //             description: values.description,
    //             order_number: values.order_number,
    //             status: values.status,
    //             title: values.title,
    //             total_user: values.total_user,
    //             lock_code: values.lock_code,
    //             timer: values.timer,
    //             imageUrl,
    //             modelUrl,
    //             backgroundUrl,
    //             date: Date.now(),
    //           }).then((resp) => {
    //             dispatch(
    //               createStage({
    //                 data_game: {
    //                   social_media: selectValues.social_media_selected,
    //                   gallery_photo: selectValues.gallery_photo_selected,
    //                   gallery_video: selectValues.gallery_video_selected,
    //                   map: selectValues.map_selected,
    //                   chat: selectValues.chat_selected,
    //                   camera: selectValues.camera_selected,
    //                   phone: selectValues.phone_selected,
    //                   contact: selectValues.contact_selected,
    //                   news: selectValues.browser_selected,
    //                 },
    //                 description: values.description,
    //                 order_number: values.order_number,
    //                 status: values.status,
    //                 title: values.title,
    //                 total_user: values.total_user,
    //                 lock_code: values.lock_code,
    //                 timer: values.timer,
    //                 imageUrl,
    //                 modelUrl,
    //                 backgroundUrl,
    //                 date: Date.now(),
    //               })
    //             )
    //             message.success(`Create stage with title '${values.title}'`)
    //             setSubmitLoading(false)
    //             history.push(`/app/stages`)
    //           })
    //         } catch (e) {
    //           console.log(e)
    //         }
    //       }
    //       if (mode === EDIT) {
    //         if (
    //           imageOriginal === '' &&
    //           backgroundOriginal === '' &&
    //           modelOriginal === ''
    //         ) {
    //           console.log(selectValues)
    //           values.date = moment(values.date, 'YYYY-MM-DD').valueOf() / 1000
    //           FirebaseService.updateStage(stageData.id, {
    //             data_game: {
    //               social_media: selectValues.social_media_selected,
    //               gallery_photo: selectValues.gallery_photo_selected,
    //               gallery_video: selectValues.gallery_video_selected,
    //               map: selectValues.map_selected,
    //               chat: selectValues.chat_selected,
    //               camera: selectValues.camera_selected,
    //               phone: selectValues.phone_selected,
    //               contact: selectValues.contact_selected,
    //               news: selectValues.browser_selected,
    //             },
    //             description: values.description,
    //             order_number: values.order_number,
    //             status: values.status,
    //             title: values.title,
    //             total_user: values.total_user,
    //             lock_code: values.lock_code,
    //             timer: values.timer,
    //             imageUrl: uploadedImg,
    //             backgroundUrl: uploadedBackground,
    //             modelUrl: uploadedModel,
    //           }).then((resp) => {
    //             dispatch(
    //               updateStage({
    //                 data_game: {
    //                   social_media: selectValues.social_media_selected,
    //                   gallery_photo: selectValues.gallery_photo_selected,
    //                   gallery_video: selectValues.gallery_video_selected,
    //                   map: selectValues.map_selected,
    //                   chat: selectValues.chat_selected,
    //                   camera: selectValues.camera_selected,
    //                   phone: selectValues.phone_selected,
    //                   contact: selectValues.contact_selected,
    //                   news: selectValues.browser_selected,
    //                 },
    //                 description: values.description,
    //                 order_number: values.order_number,
    //                 status: values.status,
    //                 title: values.title,
    //                 total_user: values.total_user,
    //                 lock_code: values.lock_code,
    //                 timer: values.timer,
    //                 imageUrl: uploadedImg,
    //                 modelUrl: uploadedModel,
    //                 backgroundUrl: uploadedBackground,
    //               })
    //             )
    //             message.success(
    //               `Stage with title '${values.title}' has updated`
    //             )
    //             setSubmitLoading(false)
    //             history.push(`/app/stages`)
    //           })
    //         } else {
    //           let imageUrl = uploadedImg
    //           let modelUrl = uploadedModel
    //           let backgroundUrl = uploadedBackground

    //           // Jika terdapat gambar imageOriginal
    //           if (imageOriginal !== '') {
    //             const fileName = `images/stages/${Date.now()}-${
    //               imageOriginal.name
    //             }`
    //             const fileRef = storage.ref().child(fileName)
    //             try {
    //               const designFile = await fileRef.put(
    //                 imageOriginal.originFileObj
    //               )
    //               imageUrl = await designFile.ref.getDownloadURL()
    //             } catch (e) {
    //               console.log(e)
    //             }
    //           }

    //           // Jika terdapat gambar backgroundOriginal
    //           if (backgroundOriginal !== '') {
    //             const backgroundName = `models/stages/${Date.now()}-${
    //               backgroundOriginal.name
    //             }`
    //             const backgroundRef = storage.ref().child(backgroundName)
    //             try {
    //               const backgroundFile = await backgroundRef.put(
    //                 backgroundOriginal.originFileObj
    //               )
    //               backgroundUrl = await backgroundFile.ref.getDownloadURL()
    //             } catch (e) {
    //               console.log(e)
    //             }
    //           }

    //           // Jika terdapat gambar modelOriginal
    //           if (modelOriginal !== '') {
    //             const modelName = `models/stages/${Date.now()}-${
    //               modelOriginal.name
    //             }`
    //             const modelRef = storage.ref().child(modelName)
    //             try {
    //               const modelFile = await modelRef.put(
    //                 modelOriginal.originFileObj
    //               )
    //               modelUrl = await modelFile.ref.getDownloadURL()
    //             } catch (e) {
    //               console.log(e)
    //             }
    //           }

    //           // Proses update dengan gambar
    //           FirebaseService.updateStage(stageData.id, {
    //             data_game: {
    //               social_media: selectValues.social_media_selected,
    //               gallery_photo: selectValues.gallery_photo_selected,
    //               gallery_video: selectValues.gallery_video_selected,
    //               map: selectValues.map_selected,
    //               chat: selectValues.chat_selected,
    //               camera: selectValues.camera_selected,
    //               phone: selectValues.phone_selected,
    //               contact: selectValues.contact_selected,
    //               news: selectValues.browser_selected,
    //             },
    //             description: values.description,
    //             order_number: values.order_number,
    //             status: values.status,
    //             title: values.title,
    //             total_user: values.total_user,
    //             lock_code: values.lock_code,
    //             timer: values.timer,
    //             imageUrl,
    //             modelUrl,
    //             backgroundUrl,
    //           }).then((resp) => {
    //             dispatch(
    //               updateStage({
    //                 data_game: {
    //                   social_media: selectValues.social_media_selected,
    //                   gallery_photo: selectValues.gallery_photo_selected,
    //                   gallery_video: selectValues.gallery_video_selected,
    //                   map: selectValues.map_selected,
    //                   chat: selectValues.chat_selected,
    //                   camera: selectValues.camera_selected,
    //                   phone: selectValues.phone_selected,
    //                   contact: selectValues.contact_selected,
    //                   news: selectValues.browser_selected,
    //                 },
    //                 description: values.description,
    //                 order_number: values.order_number,
    //                 status: values.status,
    //                 title: values.title,
    //                 total_user: values.total_user,
    //                 lock_code: values.lock_code,
    //                 timer: values.timer,
    //                 imageUrl,
    //                 modelUrl,
    //                 backgroundUrl,
    //               })
    //             )
    //             message.success(
    //               `Stage with title '${values.title}' has updated`
    //             )
    //             setSubmitLoading(false)
    //             history.push(`/app/stages`)
    //           })
    //         }
    //       }
    //     }, 1500)
    //   })
    //   .catch((info) => {
    //     setSubmitLoading(false)
    //     console.log('info', info)
    //     message.error('Please enter all required field ')
    //   })
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
                  uploadedImg={uploadedImg}
                  uploadLoading={uploadLoading}
                  handleUploadChange={handleUploadChange}
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
