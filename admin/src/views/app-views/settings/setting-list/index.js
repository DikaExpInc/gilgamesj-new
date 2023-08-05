import React, { useState, useEffect } from "react";
import PageHeaderAlt from "components/layout-components/PageHeaderAlt";
import { Tabs, Form, Button, message, Spin } from "antd";
import Flex from "components/shared-components/Flex";
import GeneralField from "./GeneralField";
import { updateSetting } from "redux/actions";
import FirebaseService from "services/FirebaseService";
import { useDispatch } from "react-redux";
import { useHistory } from "react-router-dom";
import { colorPrimary } from "configs/AppConfig";
import moment from "moment";

const { TabPane } = Tabs;

const ADD = "ADD";

const SettingForm = (props) => {
  const { mode = ADD } = props;

  let history = useHistory();
  const [form] = Form.useForm();
  const dispatch = useDispatch();
  const [pageData, setPageData] = useState("");
  const [valueClap, setValueClap] = useState("");
  const [statusClap, setStatusClap] = useState("");
  const [submitLoading, setSubmitLoading] = useState(false);
  const [loadingData, setLoadingData] = useState(true);
  const [settingData, setSettingData] = useState({});

  useEffect(() => {
    const id = "S39qHZTYKj0scL9REJfR";
    FirebaseService.getSettingDetail(id).then((querySnapshot) => {
      setSettingData({ ...querySnapshot.data(), id: querySnapshot.id });
      form.setFieldsValue({
        page: querySnapshot.data().page,
      });
      setPageData(querySnapshot.data().page);
      setLoadingData(false);
    });

    const idClap = "67tjgzl3kIytfIRKV0K5";
    FirebaseService.getSettingDetail(idClap).then((querySnapshot) => {
      setSettingData({ ...querySnapshot.data(), id: querySnapshot.id });
      form.setFieldsValue({
        value_clap: querySnapshot.data().value_clap,
        status_finish: querySnapshot.data().status_finish,
      });
      setValueClap(querySnapshot.data().valueClap);
      setStatusClap(querySnapshot.data().status_finish);
      setLoadingData(false);
    });
  }, [form, mode, props]);

  const onFinish = () => {
    setSubmitLoading(true);
    // this code is use to change page in phone like view black screen, presentasion screen, group screen
    form
      .validateFields()
      .then((values) => {
        setTimeout(async () => {
          values.date = moment(values.date, "YYYY-MM-DD").valueOf() / 1000;
          FirebaseService.updateSetting("S39qHZTYKj0scL9REJfR", {
            page: values.page,
          }).then((resp) => {
            dispatch(
              updateSetting({
                page: values.page,
              })
            );
            message.success(`Setting has updated`);
            setSubmitLoading(false);
            history.push(`/app/settings`);
          });
        }, 1500);
      })
      .catch((info) => {
        setSubmitLoading(false);
        console.log("info", info);
        message.error("Please enter all required field ");
      });
  };

  return (
    <>
      <Form
        layout="vertical"
        form={form}
        name="advanced_search"
        className="ant-advanced-search-form"
        initialValues={{
          page: pageData,
          value_clap: valueClap,
          status_finish: statusClap,
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
                {mode === "ADD" ? "Add Setting" : `Edit Setting`}{" "}
              </h2>
              <div className="mb-3">
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
                  Save
                </Button>
              </div>
            </Flex>
          </div>
        </PageHeaderAlt>
        <div className="container">
          <Tabs defaultActiveKey="1" style={{ marginTop: 30 }}>
            <TabPane tab="General" key="1">
              {loadingData && <Spin size="large" tip="Please Wait" />}
              {!loadingData && <GeneralField clapStatus={pageData} />}
            </TabPane>
          </Tabs>
        </div>
      </Form>
    </>
  );
};

export default SettingForm;
