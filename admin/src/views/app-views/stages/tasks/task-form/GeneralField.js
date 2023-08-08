import React, { useState } from 'react'
import {
  Input,
  Row,
  Col,
  Card,
  Form,
  Upload,
  message,
  Switch,
  Select,
} from 'antd'
import { ImageSvg } from 'assets/svg/icon'
import CustomIcon from 'components/util-components/CustomIcon'
import { LoadingOutlined } from '@ant-design/icons'
import { useEffect } from 'react'
import { useDispatch } from 'react-redux'
import {
  getAllChat,
  getAllGalleryPhoto,
  getAllGalleryVideo,
  getAllMaps,
  getAllSocialMedia,
  getAllStage,
} from 'redux/actions'

const { Dragger } = Upload

const rules = {
  stage_id: [
    {
      required: true,
      message: 'Please fill stage id',
    },
  ],
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
  type: [
    {
      required: true,
      message: 'Please fill type',
    },
  ],
  is_bonus: [
    {
      required: true,
      message: 'Please fill is bonus',
    },
  ],
  status: [
    {
      required: true,
      message: 'Please fill status',
    },
  ],
}

const imageUploadProps = {
  name: 'file',
  multiple: true,
  listType: 'picture-card',
  showUploadList: false,
}

const beforeUpload = (file) => {
  const isJpgOrPng = file.type === 'image/jpeg' || file.type === 'image/png'
  if (!isJpgOrPng) {
    message.error('You can only upload JPG/PNG file!')
  }
  const isLt2M = file.size / 1024 / 1024 < 2
  if (!isLt2M) {
    message.error('Image must smaller than 2MB!')
  }
  return isJpgOrPng && isLt2M
}

const GeneralField = (props) => {
  const dispatch = useDispatch()
  const [list, setList] = useState([])
  const [stage, setStage] = useState([])

  useEffect(() => {
    // FirebaseService.getStage()
    //   .then((querySnapshot) => {
    //     let listData = []
    //     querySnapshot.forEach((doc) => {
    //       listData.push({
    //         label: `stage ${doc.data().order_number} - ${doc.data().title}`,
    //         value: doc.id,
    //       })
    //     })
    //     dispatch(getAllStage(listData))
    //     setStage(listData)
    //   })
    //   .catch((error) => {
    //     console.log('Error getting document:', error)
    //   })
  }, [])

  const handleChange = (type) => {
    // switch (type) {
    //   case 'social media':
    //     FirebaseService.getSocialMedia()
    //       .then((querySnapshot) => {
    //         let listData = []
    //         querySnapshot.forEach((doc) => {
    //           listData.push({
    //             value: doc.id,
    //             label: 'Social Media - ' + doc.data().name,
    //           })
    //         })
    //         dispatch(getAllSocialMedia(listData))
    //         setList(listData)
    //       })
    //       .catch((error) => {
    //         console.log('Error getting document:', error)
    //       })
    //     break
    //   case 'gallery photo':
    //     FirebaseService.getGalleryPhoto()
    //       .then((querySnapshot) => {
    //         let listData = []
    //         querySnapshot.forEach((doc) => {
    //           listData.push({
    //             value: doc.id,
    //             label: 'Photo - ' + doc.data().name,
    //           })
    //         })
    //         dispatch(getAllGalleryPhoto(listData))
    //         setList(listData)
    //       })
    //       .catch((error) => {
    //         console.log('Error getting document:', error)
    //       })
    //     break
    //   case 'gallery video':
    //     FirebaseService.getGalleryVideo()
    //       .then((querySnapshot) => {
    //         let listData = []
    //         querySnapshot.forEach((doc) => {
    //           listData.push({
    //             value: doc.id,
    //             label: 'Photo - ' + doc.data().name,
    //           })
    //         })
    //         dispatch(getAllGalleryVideo(listData))
    //         setList(listData)
    //       })
    //       .catch((error) => {
    //         console.log('Error getting document:', error)
    //       })
    //     break
    //   case 'maps':
    //     FirebaseService.getMaps()
    //       .then((querySnapshot) => {
    //         let listData = []
    //         querySnapshot.forEach((doc) => {
    //           listData.push({
    //             value: doc.id,
    //             label: 'Maps - ' + doc.data().label,
    //           })
    //         })
    //         dispatch(getAllMaps(listData))
    //         setList(listData)
    //       })
    //       .catch((error) => {
    //         console.log('Error getting document:', error)
    //       })
    //     break
    //   case 'chat':
    //     FirebaseService.getChat()
    //       .then((querySnapshot) => {
    //         let listData = []
    //         querySnapshot.forEach((doc) => {
    //           listData.push({
    //             value: doc.id,
    //             label: 'Chat - ' + doc.data().name,
    //           })
    //         })
    //         dispatch(getAllChat(listData))
    //         setList(listData)
    //       })
    //       .catch((error) => {
    //         console.log('Error getting document:', error)
    //       })
    //     break
    //   case 'camera':
    //     break
    //   case 'phone':
    //     break
    //   case 'browser':
    //     break
    //   default:
    //     break
    // }
  }

  return (
    <Row gutter={16}>
      <Col xs={24} sm={24} md={17}>
        <Card title="Task Information">
          <Form.Item name="stage_id" label="Stage" rules={rules.stage_id}>
            <Select
              showSearch
              style={{ width: '100%' }}
              placeholder="Type Stage"
              options={stage}
            />
          </Form.Item>
          <Form.Item name="title" label="Task Title" rules={rules.title}>
            <Input placeholder="Task Title" />
          </Form.Item>
          <Form.Item
            name="description"
            label="Task Description"
            rules={rules.description}
          >
            <Input.TextArea rows={4} placeholder="Task Description" />
          </Form.Item>
          <Form.Item name="type" label="Type Task" rules={rules.description}>
            <Select
              placeholder="Type Task"
              showSearch
              style={{ width: '100%' }}
              onChange={handleChange}
              options={[
                { value: 'social media', label: 'Social Media' },
                { value: 'gallery photo', label: 'Gallery Photo' },
                { value: 'gallery video', label: 'Gallery Video' },
                { value: 'maps', label: 'Maps' },
                { value: 'chat', label: 'Chat' },
                { value: 'camera', label: 'Camera' },
                { value: 'phone', label: 'Phone' },
                { value: 'contact', label: 'Contact' },
                { value: 'browser', label: 'Browser' },
              ]}
            />
          </Form.Item>

          <Form.Item
            name="detail_id"
            label="Type Detail Task"
            rules={rules.detail_id}
          >
            <Select
              placeholder="Type Detail Task"
              showSearch
              style={{ width: '100%' }}
              options={list}
            />
          </Form.Item>
          <Form.Item
            name="is_bonus"
            label="Is Bonus Task ?"
            rules={rules.is_bonus}
          >
            <Switch
              checkedChildren="Bonus Task"
              unCheckedChildren="Normal Task"
            />
          </Form.Item>

          <Form.Item name="status" label="Status Task" rules={rules.status}>
            <Switch checkedChildren="On" unCheckedChildren="Off" />
          </Form.Item>
        </Card>
      </Col>
      <Col xs={24} sm={24} md={7}>
        <Card title="Media">
          <Dragger
            {...imageUploadProps}
            beforeUpload={beforeUpload}
            onChange={(e) => props.handleUploadChange(e)}
          >
            {props.uploadedImg ? (
              <img src={props.uploadedImg} alt="avatar" className="img-fluid" />
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
      </Col>
    </Row>
  )
}

export default GeneralField
