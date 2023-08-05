import React from "react";
import { Input, Row, Col, Card, Form, Upload, message, DatePicker } from "antd";
import { AudioSvg, ImageSvg } from "assets/svg/icon";
import CustomIcon from "components/util-components/CustomIcon";
import { LoadingOutlined } from "@ant-design/icons";

const { Dragger } = Upload;

const rules = {
  name: [
    {
      required: true,
      message: "Please fill name",
    },
  ],
  code: [
    {
      required: true,
      message: "Please fill code",
    },
    {
      validator: (_, value) => {
        if (!value || /^[0-9]+$/.test(value)) {
          return Promise.resolve();
        }
        return Promise.reject("Please enter numbers only");
      },
    },
  ],
};

const imageUploadProps = {
  name: "file",
  multiple: false,
  listType: "picture-card",
  showUploadList: false,
};

const audioUploadProps = {
  name: "audio",
  multiple: false,
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

const beforeUploadAudio = (file) => {
  const allowedTypes = ["audio/mpeg", "audio/wav"]; // Jenis file audio yang diizinkan
  const isAllowedType = allowedTypes.includes(file.type);

  if (!isAllowedType) {
    message.error("You can only upload MP3/WAV audio files!");
  }

  const isLt2M = file.size / 1024 / 1024 < 2; // Batasan ukuran file 2MB
  if (!isLt2M) {
    message.error("Audio file must be smaller than 2MB!");
  }

  return isAllowedType && isLt2M;
};

const GeneralField = (props) => (
  <Row gutter={16}>
    <Col xs={24} sm={24} md={17}>
      <Card title="Phone Information">
        <Form.Item name="name" label="Phone Name" rules={rules.name}>
          <Input placeholder="Phone Name" />
        </Form.Item>
        <Form.Item name="code" label="Phone code" rules={rules.code}>
          <Input placeholder="Phone code" />
        </Form.Item>
      </Card>
    </Col>
    <Col xs={24} sm={24} md={7}>
      <Card title="Profile">
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
      <Card title="Audio">
        <Dragger
          {...audioUploadProps}
          beforeUpload={beforeUploadAudio}
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
);

export default GeneralField;
