import React from 'react'
import { Input, Row, Col, Card, Form, Upload } from 'antd'
import { AudioSvg, ImageSvg } from 'assets/svg/icon'
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
  phone_number: [
    {
      required: true,
      message: 'Please fill phone_number',
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

const audioUploadProps = {
  name: 'audio',
  multiple: false,
  showUploadList: false,
}

const GeneralField = (props) => (
  <Row gutter={16}>
    <Col xs={24} sm={24} md={17}>
      <Card title="Phone Information">
        <Form.Item name="name" label="Phone Name" rules={rules.name}>
          <Input placeholder="Phone Name" />
        </Form.Item>
        <Form.Item
          name="phone_number"
          label="Phone Number"
          rules={rules.phone_number}
        >
          <Input placeholder="Phone number" />
        </Form.Item>
      </Card>
    </Col>
    <Col xs={24} sm={24} md={7}>
      <Card title="Profile">
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
      <Card title="Audio">
        <Dragger
          {...audioUploadProps}
          onChange={(e) => props.handleUploadAudioChange(e)}
        >
          {props.uploadedAudio ? (
            <audio src={props.uploadedAudio} controls />
          ) : (
            <div>
              {props.uploadAudioLoading ? (
                <div>
                  <LoadingOutlined className="font-size-xxl text-primary" />
                  <div className="mt-3">Uploading</div>
                </div>
              ) : (
                <div>
                  <CustomIcon className="display-3" svg={AudioSvg} />
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
