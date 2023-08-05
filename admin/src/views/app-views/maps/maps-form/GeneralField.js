import React from "react";
import {
  Input,
  Row,
  Col,
  Card,
  Form,
  Upload,
  message,
  InputNumber,
} from "antd";
import { ImageSvg } from "assets/svg/icon";
import CustomIcon from "components/util-components/CustomIcon";
import { LoadingOutlined } from "@ant-design/icons";
import TextArea from "antd/lib/input/TextArea";

const { Dragger } = Upload;

const rules = {
  label: [
    {
      required: true,
      message: "Please fill label",
    },
  ],
  latitude: [
    {
      required: true,
      message: "Please fill latitude",
    },
  ],
  longitude: [
    {
      required: true,
      message: "Please fill longitude",
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
      <Card title="Maps Information">
        <Form.Item name="label" label="Maps Label" rules={rules.label}>
          <Input placeholder="Maps Label" />
        </Form.Item>
        <Form.Item
          name="description"
          label="Maps Description"
          rules={rules.description}
        >
          <TextArea placeholder="Maps Description" />
        </Form.Item>
        <Form.Item name="latitude" label="Maps Latitude" rules={rules.latitude}>
          <InputNumber placeholder="Maps Latitude" style={{ width: "100%" }} />
        </Form.Item>
        <Form.Item
          name="longitude"
          label="Maps Longitude"
          rules={rules.longitude}
        >
          <InputNumber placeholder="Maps Longitude" style={{ width: "100%" }} />
        </Form.Item>
      </Card>
    </Col>
    <Col xs={24} sm={24} md={7}>
      <Card title="Icon">
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
