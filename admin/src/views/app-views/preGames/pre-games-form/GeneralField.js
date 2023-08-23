import React, { useCallback, useEffect, useState } from "react";
import { Input, Row, Col, Card, Form, Upload, InputNumber, Select } from "antd";
import { ImageSvg } from "assets/svg/icon";
import CustomIcon from "components/util-components/CustomIcon";
import { LoadingOutlined } from "@ant-design/icons";
import TextArea from "antd/lib/input/TextArea";
import { useDispatch } from "react-redux";
import chatService from "services/ChatService";
import cameraService from "services/CameraService";
import { getAllCamera, getAllChat } from "redux/actions";

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
  order_number: [
    {
      required: true,
      message: "Please fill order number",
    },
  ],
};

const imageUploadProps = {
  name: "file",
  multiple: false,
  showUploadList: false,
};

const GeneralField = (props) => {
  const dispatch = useDispatch();

  const [chat, setChat] = useState([]);
  const [camera, setCamera] = useState([]);
  // eslint-disable-next-line no-unused-vars
  const [mode, setMode] = useState([
    {
      value: "chat",
      label: "Mode - Chat",
    },
    {
      value: "camera",
      label: "Mode - Camera",
    },
  ]);

  const handleInputChange = useCallback(
    (name, value) => {
      if (name === "mode_selected") {
        props.setSelectValues(() => ({
          mode_selected: value,
          chat_selected: null,
          camera_selected: null,
        }));
      } else {
        props.setSelectValues((prevValues) => ({
          ...prevValues,
          [name]: value,
        }));
      }
    },
    [props]
  );

  useEffect(() => {
    // get chats
    chatService
      .getChatList()
      .then((querySnapshot) => {
        let listData = [];
        querySnapshot.data.forEach((doc) => {
          listData.push({
            value: doc._id,
            label: "Chat - " + doc.name,
          });
        });
        dispatch(getAllChat(listData));
        setChat(listData);
      })
      .catch((error) => {
        console.log("Error getting document:", error);
      });
    // get cameras
    cameraService
      .getCameraList()
      .then((querySnapshot) => {
        let listData = [];
        querySnapshot.data.forEach((doc) => {
          listData.push({
            value: doc._id,
            label: "Camera - " + doc.name,
          });
        });
        dispatch(getAllCamera(listData));
        setCamera(listData);
      })
      .catch((error) => {
        console.log("Error getting document:", error);
      });
  }, [dispatch]);
  return (
    <Row gutter={16}>
      <Col xs={24} sm={24} md={17}>
        <Card title="Pre Games Information">
          <Form.Item name="title" label="Pre Games Title" rules={rules.title}>
            <Input placeholder="Pre Games Title" />
          </Form.Item>
          <Form.Item
            name="description"
            label="Pre Games Description"
            rules={rules.description}
          >
            <TextArea placeholder="Pre Games Description" />
          </Form.Item>
          <Form.Item
            name="order_number"
            label="Pre Games Order"
            rules={rules.longitude}
          >
            <InputNumber
              placeholder="Pre Games Order"
              style={{ width: "100%" }}
            />
          </Form.Item>

          <Form.Item name="mode" label="Select Mode">
            <Select
              placeholder="Please select"
              style={{ width: "100%" }}
              options={mode}
              onChange={(value) => handleInputChange("mode_selected", value)}
              defaultValue={props.selectValues.mode_selected}
            />
          </Form.Item>

          {props.selectValues.mode_selected === "chat" ? (
            <Form.Item name="chat_list" label="Chat">
              <Select
                placeholder="Please select"
                style={{ width: "100%" }}
                options={chat}
                onChange={(value) => handleInputChange("chat_selected", value)}
                value={props.selectValues.chat_selected}
                defaultValue={props.selectValues.chat_selected}
              />
            </Form.Item>
          ) : null}

          {props.selectValues.mode_selected === "camera" ? (
            <Form.Item name="camera_list" label="Camera">
              <Select
                placeholder="Please select"
                style={{ width: "100%" }}
                options={camera}
                onChange={(value) =>
                  handleInputChange("camera_selected", value)
                }
                value={props.selectValues.camera_selected}
                defaultValue={props.selectValues.camera_selected}
              />
            </Form.Item>
          ) : null}
        </Card>
      </Col>
      <Col xs={24} sm={24} md={7}>
        <Card title="Icon">
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
  );
};

export default GeneralField;
