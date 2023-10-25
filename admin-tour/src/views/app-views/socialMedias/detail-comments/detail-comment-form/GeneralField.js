import React from 'react'
import { Input, Row, Col, Card, Form, Upload } from 'antd'
import { ImageSvg } from 'assets/svg/icon'
import CustomIcon from 'components/util-components/CustomIcon'
import { LoadingOutlined } from '@ant-design/icons'
import TextArea from 'antd/lib/input/TextArea'

const { Dragger } = Upload

const rules = {
  name: [
    {
      required: true,
      message: 'Please fill name',
    },
  ],
  comment: [
    {
      required: true,
      message: 'Please fill code',
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
      <Card title="Comment Information">
        <Form.Item name="name" label="Name" rules={rules.name}>
          <Input placeholder="Name" />
        </Form.Item>
        <Form.Item name="comment" label="Comment" rules={rules.comment}>
          <TextArea placeholder="Comment" />
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
    </Col>
  </Row>
)

export default GeneralField
