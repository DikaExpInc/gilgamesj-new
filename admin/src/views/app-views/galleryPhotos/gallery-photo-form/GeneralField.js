import React from 'react'
import { Input, Row, Col, Card, Form, Upload, message, DatePicker } from 'antd'
import { ImageSvg } from 'assets/svg/icon'
import CustomIcon from 'components/util-components/CustomIcon'
import { LoadingOutlined } from '@ant-design/icons'

const { Dragger } = Upload

const rules = {
  title: [
    {
      required: true,
      message: 'Please fill title',
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
  name: 'file',
  multiple: false,
  showUploadList: false,
}

const GeneralField = (props) => (
  <Row gutter={16}>
    <Col xs={24} sm={24} md={17}>
      <Card title="Gallery Photo Information">
        <Form.Item name="title" label="Photo Title" rules={rules.title}>
          <Input placeholder="Photo Title" />
        </Form.Item>
        <Form.Item name="date" label="Photo Date" rules={rules.date}>
          <DatePicker placeholder="Photo Date" style={{ width: '100%' }} />
        </Form.Item>
      </Card>
    </Col>
    <Col xs={24} sm={24} md={7}>
      <Card title="Media">
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
