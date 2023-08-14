import React, { useEffect, useState } from 'react'
import { Input, Row, Col, Card, Form, Select } from 'antd'
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

const GeneralField = (props) => {
  const dispatch = useDispatch()
  const [list, setList] = useState([])

  useEffect(() => {
    switch (props.form.getFieldValue('type')) {
      case 'social media':
        socialMediaService
          .getSocialMediaList()
          .then((querySnapshot) => {
            let listData = []
            querySnapshot.data.forEach((doc) => {
              console.log(doc)
              listData.push({
                value: doc._id,
                label: 'Social Media - ' + doc.name,
              })
            })
            dispatch(getAllSocialMedia(listData))
            setList(listData)
          })
          .catch((error) => {
            console.log('Error getting document:', error)
          })
        break
      case 'gallery photo':
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
            setList(listData)
          })
          .catch((error) => {
            console.log('Error getting document:', error)
          })
        break
      case 'gallery video':
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
            setList(listData)
          })
          .catch((error) => {
            console.log('Error getting document:', error)
          })
        break
      case 'maps':
        mapService
          .getMapList()
          .then((querySnapshot) => {
            let listData = []
            querySnapshot.data.forEach((doc) => {
              listData.push({
                value: doc._id,
                label: 'Maps - ' + doc.title,
              })
            })
            dispatch(getAllMaps(listData))
            setList(listData)
          })
          .catch((error) => {
            console.log('Error getting document:', error)
          })
        break
      case 'chat':
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
            setList(listData)
          })
          .catch((error) => {
            console.log('Error getting document:', error)
          })
        break
      case 'camera':
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
            setList(listData)
          })
          .catch((error) => {
            console.log('Error getting document:', error)
          })
        break
      case 'phone':
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
            setList(listData)
          })
          .catch((error) => {
            console.log('Error getting document:', error)
          })
        break
      case 'contact':
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
            setList(listData)
          })
          .catch((error) => {
            console.log('Error getting document:', error)
          })
        break
      case 'browser':
        newsService
          .getBrowserList()
          .then((querySnapshot) => {
            let listData = []
            querySnapshot.data.forEach((doc) => {
              listData.push({
                value: doc._id,
                label: 'Browser - ' + doc.title,
              })
            })
            dispatch(getAllNews(listData))
            setList(listData)
          })
          .catch((error) => {
            console.log('Error getting document:', error)
          })
        break
      default:
        break
    }
  }, [dispatch, props.form])

  const handleChange = (type) => {
    props.form.setFieldsValue({ detail_id: undefined })
    switch (type) {
      case 'social media':
        socialMediaService
          .getSocialMediaList()
          .then((querySnapshot) => {
            let listData = []
            querySnapshot.data.forEach((doc) => {
              console.log(doc)
              listData.push({
                value: doc._id,
                label: 'Social Media - ' + doc.name,
              })
            })
            dispatch(getAllSocialMedia(listData))
            setList(listData)
          })
          .catch((error) => {
            console.log('Error getting document:', error)
          })
        break
      case 'gallery photo':
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
            setList(listData)
          })
          .catch((error) => {
            console.log('Error getting document:', error)
          })
        break
      case 'gallery video':
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
            setList(listData)
          })
          .catch((error) => {
            console.log('Error getting document:', error)
          })
        break
      case 'maps':
        mapService
          .getMapList()
          .then((querySnapshot) => {
            let listData = []
            querySnapshot.data.forEach((doc) => {
              listData.push({
                value: doc._id,
                label: 'Maps - ' + doc.title,
              })
            })
            dispatch(getAllMaps(listData))
            setList(listData)
          })
          .catch((error) => {
            console.log('Error getting document:', error)
          })
        break
      case 'chat':
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
            setList(listData)
          })
          .catch((error) => {
            console.log('Error getting document:', error)
          })
        break
      case 'camera':
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
            setList(listData)
          })
          .catch((error) => {
            console.log('Error getting document:', error)
          })
        break
      case 'phone':
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
            setList(listData)
          })
          .catch((error) => {
            console.log('Error getting document:', error)
          })
        break
      case 'contact':
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
            setList(listData)
          })
          .catch((error) => {
            console.log('Error getting document:', error)
          })
        break
      case 'browser':
        newsService
          .getBrowserList()
          .then((querySnapshot) => {
            let listData = []
            querySnapshot.data.forEach((doc) => {
              listData.push({
                value: doc._id,
                label: 'Browser - ' + doc.title,
              })
            })
            dispatch(getAllNews(listData))
            setList(listData)
          })
          .catch((error) => {
            console.log('Error getting document:', error)
          })
        break
      default:
        break
    }
  }

  return (
    <Row gutter={16}>
      <Col xs={24} sm={24} md={24}>
        <Card title="Task Information">
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
          <Form.Item name="type" label="Type Task" rules={rules.type}>
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
        </Card>
      </Col>
    </Row>
  )
}

export default GeneralField
