import React, { useState, useEffect } from "react";
import PageHeaderAlt from "components/layout-components/PageHeaderAlt";
import { Tabs, Form, Button, message, Spin } from "antd";
import Flex from "components/shared-components/Flex";
import GeneralField from "./GeneralField";
import { createCamera, updateCamera } from "redux/actions";
import FirebaseService from "services/FirebaseService";
import { useDispatch } from "react-redux";
import { useHistory } from "react-router-dom";
import { colorPrimary } from "configs/AppConfig";
import moment from "moment";

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

      FirebaseService.getCameraDetail(id).then((querySnapshot) => {
        setCameraData({ ...querySnapshot.data(), id: querySnapshot.id });
        form.setFieldsValue({
          name: querySnapshot.data().name,
          code: querySnapshot.data().code,
        });
        setLoadingData(false);
      });
    } else {
      setLoadingData(false);
    }
  }, [form, mode, param, props]);

  const onFinish = () => {
    setSubmitLoading(true);
    form
      .validateFields()
      .then((values) => {
        setTimeout(async () => {
          if (mode === ADD) {
            try {
              FirebaseService.addCamera({
                ...values,
                date: Date.now(),
              }).then((resp) => {
                dispatch(
                  createCamera({
                    ...values,
                    date: Date.now(),
                  })
                );
                message.success(`Create camera with name '${values.name}'`);
                setSubmitLoading(false);
                history.push(`/app/cameras`);
              });
            } catch (e) {
              console.log(e);
            }
          }
          if (mode === EDIT) {
            values.date = moment(values.date, "YYYY-MM-DD").valueOf() / 1000;
            FirebaseService.updateCamera(cameraData.id, {
              ...values,
            }).then((resp) => {
              dispatch(
                updateCamera({
                  ...values,
                })
              );
              message.success(`Camera with name '${values.name}' has updated`);
              setSubmitLoading(false);
              history.push(`/app/cameras`);
            });
          }
        }, 1500);
      })
      .catch((info) => {
        setSubmitLoading(false);
        console.log("info", info);
        message.error("Please enter all required field ");
      });
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
