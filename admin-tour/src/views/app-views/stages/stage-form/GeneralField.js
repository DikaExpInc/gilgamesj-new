import React, { useCallback, useEffect, useState } from 'react'
import { Input, Row, Col, Card, Form, Upload, InputNumber, Select } from 'antd'
import { ImageSvg } from 'assets/svg/icon'
import CustomIcon from 'components/util-components/CustomIcon'
import { LoadingOutlined } from '@ant-design/icons'
// import { Vector3 } from '@babylonjs/core/Maths/math.vector'
// import {
//   AssetManagerContext,
//   TaskType,
//   useAssetManager,
//   useBeforeRender,
// } from 'react-babylonjs'
import { useDispatch } from 'react-redux'
import {
  getAllCamera,
  getAllChat,
  getAllContact,
  getAllGalleryPhoto,
  getAllGalleryVideo,
  getAllMaps,
  getAllNews,
  getAllPhone,
  getAllSocialMedia,
} from 'redux/actions'
import socialMediaService from 'services/SocialMediaService'
import galleryPhotoService from 'services/GalleryPhotoService'
import galleryVideoService from 'services/GalleryVideoService'
import mapService from 'services/MapService'
import chatService from 'services/ChatService'
import cameraService from 'services/CameraService'
import phoneService from 'services/PhoneService'
import contactService from 'services/ContactService'
import newsService from 'services/NewsService'

// const baseUrl =
// 'https://raw.githubusercontent.com/KhronosGroup/glTF-Sample-Models/master/2.0/'
// const modelAssetTasks = [
//   {
//     taskType: TaskType.Mesh,
//     rootUrl: `${baseUrl}BoomBox/glTF/`,
//     sceneFilename: 'BoomBox.gltf',
//     name: 'boombox',
//   },
//   {
//     taskType: TaskType.Mesh,
//     rootUrl: `${baseUrl}Avocado/glTF/`,
//     sceneFilename: 'Avocado.gltf',
//     name: 'avocado',
//   },
// ]
// const MyFallback = () => {
//   const boxRef = useRef(null)
//   const context = useContext(AssetManagerContext)
//   useBeforeRender((scene) => {
//     if (boxRef.current) {
//       var deltaTimeInMillis = scene.getEngine().getDeltaTime()
//       const rpm = 10
//       boxRef.current.rotation.x = Math.PI / 4
//       boxRef.current.rotation.y +=
//         (rpm / 60) * Math.PI * 2 * (deltaTimeInMillis / 1000)
//     }
//   })
//   const eventData = context?.lastProgress?.eventData
//   return (
//     <>
//       <adtFullscreenUi name="ui">
//         <rectangle name="rect" height="50px" width="150px">
//           <rectangle>
//             {eventData !== undefined && (
//               <textBlock
//                 text={`${eventData.totalCount - eventData.remainingCount}/${
//                   eventData.totalCount
//                 }`}
//                 fontStyle="bold"
//                 fontSize={20}
//                 color="white"
//               />
//             )}
//             {eventData === undefined && (
//               <textBlock
//                 text="0/2"
//                 fontStyle="bold"
//                 fontSize={20}
//                 color="white"
//               />
//             )}
//           </rectangle>
//         </rectangle>
//       </adtFullscreenUi>
//       <box ref={boxRef} name="fallback" size={2} />
//     </>
//   )
// }
// const MyModels = () => {
//   const assetManagerResult = useAssetManager(modelAssetTasks)
//   useEffect(() => {
//     const boomboxTask = assetManagerResult.taskNameMap['boombox']
//     boomboxTask.loadedMeshes[0].position = new Vector3(2.5, 0, 0)
//     boomboxTask.loadedMeshes[1].scaling = new Vector3(20, 20, 20)
//     const avocadoTask = assetManagerResult.taskNameMap['avocado']
//     avocadoTask.loadedMeshes[0].position = new Vector3(-2.5, 0, 0)
//     avocadoTask.loadedMeshes[1].scaling = new Vector3(20, 20, 20)
//   })
//   return null
// }

const { Dragger } = Upload

const rules = {
  title: [
    {
      required: true,
      message: 'Please fill title',
    },
  ],
  description: [
    {
      required: true,
      message: 'Please fill description',
    },
  ],
  order_number: [
    {
      required: true,
      message: 'Please fill order number',
    },
    {
      validator: (_, value) => {
        if (!value || /^[0-9]+$/.test(value)) {
          return Promise.resolve()
        }
        return Promise.reject('Please enter numbers only')
      },
    },
  ],
  timer: [
    {
      required: true,
      message: 'Please fill timer',
    },
    {
      validator: (_, value) => {
        if (!value || /^[0-9]+$/.test(value)) {
          return Promise.resolve()
        }
        return Promise.reject('Please enter numbers only')
      },
    },
  ],
  total_player: [
    {
      required: true,
      message: 'Please fill total user',
    },
    {
      validator: (_, value) => {
        if (!value || /^[0-9]+$/.test(value)) {
          return Promise.resolve()
        }
        return Promise.reject('Please enter numbers only')
      },
    },
  ],
  status: [
    {
      required: true,
      message: 'Please fill status',
    },
  ],
  lock_code: [
    {
      required: true,
      message: 'Please fill lock code',
    },
  ],
}

const imageUploadProps = {
  name: 'file',
  multiple: false,
  showUploadList: false,
}

const modelUploadProps = {
  name: 'file',
  multiple: false,
  showUploadList: false,
}

// const MyScene = () => {
//   return (
//     <Engine antialias adaptToDeviceRatio canvasId="babylon-js">
//       <Scene>
//         <arcRotateCamera
//           name="camera1"
//           alpha={Math.PI / 2}
//           beta={Math.PI / 2}
//           radius={9.0}
//           target={Vector3.Zero()}
//           minZ={0.001}
//         />
//         <hemisphericLight
//           name="light1"
//           intensity={0.7}
//           direction={Vector3.Up()}
//         />
//         <AssetManagerContextProvider>
//           <Suspense fallback={<MyFallback />}>
//             <MyModels />
//           </Suspense>
//         </AssetManagerContextProvider>
//       </Scene>
//     </Engine>
//   )
// }

const GeneralField = (props) => {
  const dispatch = useDispatch()
  const [socialMedia, setSocialMedia] = useState([])
  const [galleryPhoto, setGalleryPhoto] = useState([])
  const [galleryVideo, setGalleryVideo] = useState([])
  const [maps, setMaps] = useState([])
  const [chat, setChat] = useState([])
  const [camera, setCamera] = useState([])
  const [phone, setPhone] = useState([])
  const [contact, setContact] = useState([])
  const [browser, setBrowser] = useState([])

  const handleInputChange = useCallback(
    (name, value) => {
      props.setSelectValues((prevValues) => ({
        ...prevValues,
        [name]: value,
      }))
    },
    [props]
  )

  useEffect(() => {
    // get sosmed
    socialMediaService
      .getSocialMediaList()
      .then((querySnapshot) => {
        let listData = []
        querySnapshot.data.forEach((doc) => {
          listData.push({
            value: doc._id,
            label: 'Social Media - ' + doc.name,
          })
        })
        dispatch(getAllSocialMedia(listData))
        setSocialMedia(listData)
      })
      .catch((error) => {
        console.log('Error getting document:', error)
      })
    // get gallery photo
    galleryPhotoService
      .getGalleryPhotoList()
      .then((querySnapshot) => {
        let listData = []
        querySnapshot.data.forEach((doc) => {
          listData.push({
            value: doc._id,
            label: 'Photo - ' + doc.title,
          })
        })
        dispatch(getAllGalleryPhoto(listData))
        setGalleryPhoto(listData)
      })
      .catch((error) => {
        console.log('Error getting document:', error)
      })
    // get gallery video
    galleryVideoService
      .getGalleryVideoList()
      .then((querySnapshot) => {
        let listData = []
        querySnapshot.data.forEach((doc) => {
          listData.push({
            value: doc._id,
            label: 'Video - ' + doc.title,
          })
        })
        dispatch(getAllGalleryVideo(listData))
        setGalleryVideo(listData)
      })
      .catch((error) => {
        console.log('Error getting document:', error)
      })
    // get maps
    mapService
      .getMapList()
      .then((querySnapshot) => {
        let listData = []
        querySnapshot.data.forEach((doc) => {
          listData.push({
            value: doc._id,
            label: 'Map - ' + doc.title,
          })
        })
        dispatch(getAllMaps(listData))
        setMaps(listData)
      })
      .catch((error) => {
        console.log('Error getting document:', error)
      })
    // get chats
    chatService
      .getChatList()
      .then((querySnapshot) => {
        let listData = []
        querySnapshot.data.forEach((doc) => {
          listData.push({
            value: doc._id,
            label: 'Chat - ' + doc.name,
          })
        })
        dispatch(getAllChat(listData))
        setChat(listData)
      })
      .catch((error) => {
        console.log('Error getting document:', error)
      })
    // get cameras
    cameraService
      .getCameraList()
      .then((querySnapshot) => {
        let listData = []
        querySnapshot.data.forEach((doc) => {
          listData.push({
            value: doc._id,
            label: 'Camera - ' + doc.name,
          })
        })
        dispatch(getAllCamera(listData))
        setCamera(listData)
      })
      .catch((error) => {
        console.log('Error getting document:', error)
      })
    // get phone
    phoneService
      .getPhoneList()
      .then((querySnapshot) => {
        let listData = []
        querySnapshot.data.forEach((doc) => {
          listData.push({
            value: doc._id,
            label: 'Phone - ' + doc.name,
          })
        })
        dispatch(getAllPhone(listData))
        setPhone(listData)
      })
      .catch((error) => {
        console.log('Error getting document:', error)
      })
    // get contact
    contactService
      .getContactList()
      .then((querySnapshot) => {
        let listData = []
        querySnapshot.data.forEach((doc) => {
          listData.push({
            value: doc._id,
            label: 'Contact - ' + doc.name,
          })
        })
        dispatch(getAllContact(listData))
        setContact(listData)
      })
      .catch((error) => {
        console.log('Error getting document:', error)
      })
    // get browser
    newsService
      .getBrowserList()
      .then((querySnapshot) => {
        let listData = []
        querySnapshot.data.forEach((doc) => {
          listData.push({
            value: doc._id,
            label: 'browser - ' + doc.title,
          })
        })
        dispatch(getAllNews(listData))
        setBrowser(listData)
      })
      .catch((error) => {
        console.log('Error getting document:', error)
      })
  }, [dispatch])

  return (
    <>
      <Row gutter={16}>
        <Col xs={24} sm={24} md={17}>
          <Card title="Stage Information">
            <Form.Item name="title" label="Stage title" rules={rules.title}>
              <Input placeholder="Stage title" />
            </Form.Item>
            <Form.Item
              name="description"
              label="News Description"
              rules={rules.description}
            >
              <Input.TextArea rows={4} placeholder="News Description" />
            </Form.Item>
            <Form.Item
              name="order_number"
              label="Stage order number"
              rules={rules.order_number}
            >
              <InputNumber
                placeholder="Stage order number"
                style={{ width: '100%' }}
              />
            </Form.Item>

            <Form.Item
              name="total_player"
              label="Stage total player (fill 0 to infinity player)"
              rules={rules.total_player}
            >
              <InputNumber
                placeholder="Stage total user"
                style={{ width: '100%' }}
              />
            </Form.Item>
            <Form.Item
              name="timer"
              label="Time to finish (minutes)"
              rules={rules.timer}
            >
              <InputNumber placeholder="Timer" style={{ width: '100%' }} />
            </Form.Item>
          </Card>
          <Card title="Lock Code Information">
            <Form.Item
              name="lock_code"
              label="Lock Code"
              rules={rules.lock_code}
            >
              <InputNumber placeholder="Lock Code" style={{ width: '100%' }} />
            </Form.Item>
          </Card>

          <Card title="Stage Item Information">
            <Form.Item
              name="social_media_list"
              label="Social Media"
              rules={rules.socialMediaList}
            >
              <Select
                mode="multiple"
                placeholder="Please select"
                style={{ width: '100%' }}
                options={socialMedia}
                onChange={(value) =>
                  handleInputChange('social_media_selected', value)
                }
                defaultValue={props.social_media_list}
              />
            </Form.Item>
            <Form.Item
              name="gallery_photo_list"
              label="Gallery Photo"
              rules={rules.galleryPhotoList}
            >
              <Select
                mode="multiple"
                placeholder="Please select"
                style={{ width: '100%' }}
                options={galleryPhoto}
                onChange={(value) =>
                  handleInputChange('gallery_photo_selected', value)
                }
                defaultValue={props.gallery_photo_list}
              />
            </Form.Item>
            <Form.Item
              name="gallery_video_list"
              label="Gallery Video"
              rules={rules.galleryVideoList}
            >
              <Select
                mode="multiple"
                placeholder="Please select"
                style={{ width: '100%' }}
                options={galleryVideo}
                onChange={(value) =>
                  handleInputChange('gallery_video_selected', value)
                }
                defaultValue={props.gallery_video_list}
              />
            </Form.Item>
            <Form.Item name="map_list" label="Maps" rules={rules.mapsList}>
              <Select
                mode="multiple"
                placeholder="Please select"
                style={{ width: '100%' }}
                options={maps}
                onChange={(value) => handleInputChange('map_selected', value)}
                defaultValue={props.map_list}
              />
            </Form.Item>
            <Form.Item name="chat_list" label="Chat" rules={rules.chatList}>
              <Select
                mode="multiple"
                placeholder="Please select"
                style={{ width: '100%' }}
                options={chat}
                onChange={(value) => handleInputChange('chat_selected', value)}
                defaultValue={props.chat_list}
              />
            </Form.Item>
            <Form.Item
              name="camera_list"
              label="Camera"
              rules={rules.cameraList}
            >
              <Select
                mode="multiple"
                placeholder="Please select"
                style={{ width: '100%' }}
                options={camera}
                onChange={(value) =>
                  handleInputChange('camera_selected', value)
                }
                defaultValue={props.camera_list}
              />
            </Form.Item>
            <Form.Item name="phone_list" label="Phone" rules={rules.phoneList}>
              <Select
                mode="multiple"
                placeholder="Please select"
                style={{ width: '100%' }}
                options={phone}
                onChange={(value) => handleInputChange('phone_selected', value)}
                defaultValue={props.phone_list}
              />
            </Form.Item>
            <Form.Item
              name="contact_list"
              label="Contact"
              rules={rules.contactList}
            >
              <Select
                mode="multiple"
                placeholder="Please select"
                style={{ width: '100%' }}
                options={contact}
                onChange={(value) =>
                  handleInputChange('contact_selected', value)
                }
                defaultValue={props.contact_list}
              />
            </Form.Item>
            <Form.Item
              name="news_list"
              label="News Browser"
              rules={rules.newsList}
            >
              <Select
                mode="multiple"
                placeholder="Please select"
                style={{ width: '100%' }}
                options={browser}
                onChange={(value) =>
                  handleInputChange('browser_selected', value)
                }
                defaultValue={props.news_list}
              />
            </Form.Item>
          </Card>
        </Col>

        <Col xs={24} sm={24} md={7}>
          <Card title="Gameplay Background">
            <Dragger
              {...imageUploadProps}
              onChange={(e) => props.handleUploadBackgroundChange(e)}
            >
              {props.uploadedBackground ? (
                <img
                  src={props.uploadedBackground}
                  alt="avatar"
                  className="img-fluid"
                />
              ) : (
                <div>
                  {props.uploadBackgroundLoading ? (
                    <div>
                      <LoadingOutlined className="font-size-xxl text-primary" />
                      <div className="mt-3">Uploading</div>
                    </div>
                  ) : (
                    <div>
                      <CustomIcon className="display-3" svg={ImageSvg} />
                      <p>Click or drag file to upload</p>
                    </div>
                  )}
                </div>
              )}
            </Dragger>
          </Card>

          <Card title="Objective Image">
            <Dragger
              {...imageUploadProps}
              onChange={(e) => props.handleUploadChange(e)}
            >
              {props.uploadedObjective ? (
                <img
                  src={props.uploadedObjective}
                  alt="avatar"
                  className="img-fluid"
                />
              ) : (
                <div>
                  {props.uploadLoading ? (
                    <div>
                      <LoadingOutlined className="font-size-xxl text-primary" />
                      <div className="mt-3">Uploading</div>
                    </div>
                  ) : (
                    <div>
                      <CustomIcon className="display-3" svg={ImageSvg} />
                      <p>Click or drag file to upload</p>
                    </div>
                  )}
                </div>
              )}
            </Dragger>
          </Card>

          <Card title="Objective 3D Model">
            <Dragger
              {...modelUploadProps}
              onChange={(e) => props.handleUploadModelChange(e)}
            >
              {/* <MyScene /> */}
              {/* {props.uploadedImg ? (
                <img src={props.uploadedImg} alt="avatar" className="img-fluid" />
              ) : ( */}
              <div>
                {props.uploadModelLoading ? (
                  <div>
                    <LoadingOutlined className="font-size-xxl text-primary" />
                    <div className="mt-3">Uploading</div>
                  </div>
                ) : (
                  <div>
                    <CustomIcon className="display-3" svg={ImageSvg} />
                    <p>Click or drag file to upload</p>
                  </div>
                )}
              </div>
              {/* )} */}
            </Dragger>
          </Card>
        </Col>
      </Row>
    </>
  )
}

export default GeneralField
