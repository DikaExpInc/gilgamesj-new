import React, { useState, useEffect } from "react";
import PageHeaderAlt from "components/layout-components/PageHeaderAlt";
import { Tabs, Form, Button, message, Spin } from "antd";
import Flex from "components/shared-components/Flex";
import GeneralField from "./GeneralField";
import { createCamera, updateCamera } from "redux/actions";
import { useDispatch } from "react-redux";
import { useHistory } from "react-router-dom";
import { colorPrimary } from "configs/AppConfig";
import cameraService from "services/CameraService";

const { TabPane } = Tabs;

const ADD = "ADD";
const EDIT = "EDIT";

const CameraForm = (props) => {
  const { mode = ADD, param } = props;

  let history = useHistory();
  const [form] = Form.useForm();
  const dispatch = useDispatch();
  const [submitLoading, setSubmitLoading] = useState(false);
  const [loadingData, setLoadingData] = useState(true);
  const [cameraData, setCameraData] = useState({});

  useEffect(() => {
    if (mode === EDIT) {
      const { id } = param;

      cameraService.getCamera(id).then((querySnapshot) => {
        setCameraData({ ...querySnapshot.data, _id: id });
        form.setFieldsValue({
          name: querySnapshot.data.name,
          code: querySnapshot.data.code,
          url: querySnapshot.data.url,
        });
        setLoadingData(false);
      });
    } else {
      setLoadingData(false);
    }
  }, [form, mode, param, props]);

  const onFinish = async () => {
    setSubmitLoading(true);
    try {
      const values = await form.validateFields();
      const formData = new FormData();

      if (mode === ADD) {
        for (const key in values) {
          formData.append(key, values[key]);
        }

        const resp = await cameraService.addCamera(formData);
        dispatch(createCamera(resp.data)); // Assuming the API returns the created news data
        message.success(`Create camera with name '${values.name}'`);
        history.push(`/app/cameras`);
      } else if (mode === EDIT) {
        for (const key in values) {
          formData.append(key, values[key]);
        }

        const resp = await cameraService.updateCamera(cameraData._id, formData);
        dispatch(updateCamera(resp.data)); // Assuming the API returns the updated news data
        message.success(`Camera with name '${values.name}' has updated`);
        history.push(`/app/cameras`);
      }
    } catch (error) {
      setSubmitLoading(false);
      console.log("Error:", error);
      message.error("An error occurred. Please try again later.");
    }
  };

  const onDiscard = () => {
    history.goBack();
  };

  return (
    <>
      <Form
        layout="vertical"
        form={form}
        name="advanced_search"
        className="ant-advanced-search-form"
        initialValues={{
          heightUnit: "cm",
          widthUnit: "cm",
          weightUnit: "kg",
        }}
      >
        <PageHeaderAlt className="border-bottom" overlap>
          <div className="container">
            <Flex
              className="py-2"
              mobileFlex={false}
              justifyContent="between"
              alignItems="center"
            >
              <h2 className="mb-3">
                {mode === "ADD" ? "Add Camera" : `Edit Camera`}{" "}
              </h2>
              <div className="mb-3">
                <Button className="mr-2" onClick={() => onDiscard()}>
                  Cancel
                </Button>
                <Button
                  style={{
                    backgroundColor: colorPrimary,
                    color: "white",
                    border: "none",
                  }}
                  onClick={() => onFinish()}
                  htmlType="submit"
                  loading={submitLoading}
                >
                  {mode === "ADD" ? "Add" : `Save`}
                </Button>
              </div>
            </Flex>
          </div>
        </PageHeaderAlt>
        <div className="container">
          <Tabs defaultActiveKey="1" style={{ marginTop: 30 }}>
            <TabPane tab="General" key="1">
              {loadingData && <Spin size="large" tip="Please Wait" />}
              {!loadingData && <GeneralField />}
            </TabPane>
          </Tabs>
        </div>
      </Form>
    </>
  );
};

export default CameraForm;
