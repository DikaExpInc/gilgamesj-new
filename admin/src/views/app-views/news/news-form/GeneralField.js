import React from "react";
import { Input, Row, Col, Card, Form, Upload, message } from "antd";
import { ImageSvg } from "assets/svg/icon";
import CustomIcon from "components/util-components/CustomIcon";
import { LoadingOutlined } from "@ant-design/icons";

const { Dragger } = Upload;

const rules = {
  title: [
    {
      required: true,
      message: "Please fill title",
    },
  ],
  description: [
    {
      required: true,
      message: "Please fill description",
    },
  ],
};

const imageUploadProps = {
  name: "file",
  multiple: true,
  listType: "picture-card",
  showUploadList: false,
};

const beforeUpload = (file) => {
  const isJpgOrPng = file.type === "image/jpeg" || file.type === "image/png";
  if (!isJpgOrPng) {
    message.error("You can only upload JPG/PNG file!");
  }
  const isLt2M = file.size / 1024 / 1024 < 2;
  if (!isLt2M) {
    message.error("Image must smaller than 2MB!");
  }
  return isJpgOrPng && isLt2M;
};

const GeneralField = (props) => (
  <Row gutter={16}>
    <Col xs={24} sm={24} md={17}>
      <Card title="News Information">
        <Form.Item name="title" label="News Title" rules={rules.title}>
          <Input placeholder="News Title" />
        </Form.Item>
        <Form.Item
          name="description"
          label="News Description"
          rules={rules.description}
        >
          <Input.TextArea rows={4} placeholder="News Description" />
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
);

export default GeneralField;
