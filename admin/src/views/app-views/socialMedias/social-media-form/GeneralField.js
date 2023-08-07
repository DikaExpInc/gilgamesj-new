import React from 'react'
import {
  Input,
  Row,
  Col,
  Card,
  Form,
  Upload,
  DatePicker,
  InputNumber,
} from 'antd'
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
  description: [
    {
      required: true,
      message: 'Please fill description',
    },
  ],
  location: [
    {
      required: true,
      message: 'Please fill location',
    },
  ],
  date: [
    {
      required: true,
      message: 'Please fill date',
    },
  ],
}

const imageUploadProps = {
  name: 'media',
  multiple: false,
  showUploadList: false,
}

const profileImageUploadProps = {
  name: 'profile',
  multiple: false,
  showUploadList: false,
}

const GeneralField = (props) => (
  <Row gutter={16}>
    <Col xs={24} sm={24} md={17}>
      <Card name="Media" title="Post Image">
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
      <Card name="Social Media Information">
        <Form.Item name="name" label="Social Media Name" rules={rules.name}>
          <Input placeholder="Social Media Name" />
        </Form.Item>
        <Form.Item
          name="description"
          label="Social Media Description"
          rules={rules.description}
        >
          <Input.TextArea rows={4} placeholder="Social Media Description" />
        </Form.Item>
        <Form.Item
          name="location"
          label="Social Media Location"
          rules={rules.location}
        >
          <Input placeholder="Social Media Location" />
        </Form.Item>
        <Form.Item name="date" label="Social Media Date" rules={rules.date}>
          <DatePicker
            placeholder="Social Medias Date"
            style={{ width: '100%' }}
          />
        </Form.Item>
        <Form.Item name="like" label="Social Media Like" initialValue={0}>
          <InputNumber
            placeholder="Social Media Like"
            style={{ width: '100%' }}
            readOnly
          />
        </Form.Item>
      </Card>
    </Col>
    <Col xs={24} sm={24} md={7}>
      <Card name="Profile" title="Profile">
        <Dragger
          {...profileImageUploadProps}
          onChange={(e) => props.handleUploadProfileChange(e)}
        >
          {props.profileUploadImg ? (
            <img
              src={props.profileUploadImg}
              alt="avatar"
              className="img-fluid"
            />
          ) : (
            <div>
              {props.profileUploadLoading ? (
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
