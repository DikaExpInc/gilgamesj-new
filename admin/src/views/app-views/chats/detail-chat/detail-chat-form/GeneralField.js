import React, { useEffect, useState } from 'react'
import { Input, Row, Col, Card, Form, InputNumber, Switch, Select } from 'antd'

import { useDispatch } from 'react-redux'
import { getAllDetailChat } from 'redux/actions'
import { useParams } from 'react-router-dom/cjs/react-router-dom'

// const { Dragger } = Upload;

const rules = {
  title: [
    {
      required: true,
      message: 'Please fill name',
    },
  ],
  order: [
    {
      required: true,
      message: 'Please fill order',
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
  sender: [
    {
      required: true,
      message: 'Please fill sender',
    },
  ],
}

const GeneralField = (props) => {
  const dispatch = useDispatch()
  const { chatId } = useParams()

  const [chats, setChats] = useState([])

  useEffect(() => {
    // FirebaseService.getDetailChat(chatId)
    //   .then((querySnapshot) => {
    //     let listData = []
    //     querySnapshot.forEach((doc) => {
    //       listData.push({
    //         label: `chat ${doc.data().order_number} - ${doc.data().title}`,
    //         value: doc.id,
    //       })
    //     })
    //     dispatch(getAllDetailChat(listData))
    //     setChats(listData)
    //   })
    //   .catch((error) => {
    //     console.log('Error getting document:', error)
    //   })
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [])

  return (
    <Row gutter={16}>
      <Col xs={24} sm={24} md={24}>
        <Card title="Chat Information">
          <Form.Item name="title" label="Chat title" rules={rules.title}>
            <Input placeholder="Chat title" />
          </Form.Item>
          <Form.Item name="sender" label="Chat sender" rules={rules.sender}>
            <Input placeholder="Chat sender" />
          </Form.Item>
          <Form.Item name="order" label="Chat order" rules={rules.order}>
            <InputNumber placeholder="Chat sender" style={{ width: '100%' }} />
          </Form.Item>
          <Form.Item name="status" label="Chat Status" rules={rules.status}>
            <Switch checkedChildren="sender" unCheckedChildren="receiver" />
          </Form.Item>
          <Form.Item
            name="chat_sibling_id"
            label="Chat Sibling ID"
            rules={rules.chat_sibling_id}
          >
            <Select
              showSearch
              style={{ width: '100%' }}
              placeholder="Type Chat Sibling"
              options={chats}
            />
          </Form.Item>
          <Form.Item
            name="chat_family_id"
            label="Chat Family ID"
            rules={rules.chat_family_id}
          >
            <Select
              showSearch
              style={{ width: '100%' }}
              placeholder="Type Chat Family"
              options={chats}
            />
          </Form.Item>
        </Card>
      </Col>
    </Row>
  )
}

export default GeneralField
