import React from 'react'
import { Input, Row, Col, Card, Form, Upload } from 'antd'
import { ImageSvg } from 'assets/svg/icon'
import CustomIcon from 'components/util-components/CustomIcon'
import { LoadingOutlined } from '@ant-design/icons'

const { Dragger } = Upload

const rules = {
  name: [
    {
      required: true,
      message: 'Please fill name',
    },
  ],
  contact_number: [
    {
      required: true,
      message: 'Please fill contact',
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
}

const imageUploadProps = {
  name: 'file',
  multiple: false,
  showUploadList: false,
}

const GeneralField = (props) => (
  <Row gutter={16}>
    <Col xs={24} sm={24} md={17}>
      <Card title="Chat Information">
        <Form.Item name="name" label="Chat Name" rules={rules.name}>
          <Input placeholder="Chat Name" />
        </Form.Item>
        <Form.Item
          name="contact_number"
          label="Chat Contact"
          rules={rules.contact_number}
        >
          <Input placeholder="Chat Contact" style={{ width: '100%' }} />
        </Form.Item>
      </Card>
    </Col>
    <Col xs={24} sm={24} md={7}>
      <Card title="Photo Profile">
        <Dragger
          {...imageUploadProps}
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

export default GeneralField
