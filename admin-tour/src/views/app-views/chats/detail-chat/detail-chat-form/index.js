import React, { useState, useEffect } from "react";
import PageHeaderAlt from "components/layout-components/PageHeaderAlt";
import { Tabs, Form, Button, message, Spin } from "antd";
import Flex from "components/shared-components/Flex";
import GeneralField from "./GeneralField";
import { useDispatch } from "react-redux";
import { useHistory } from "react-router-dom";
import { colorPrimary } from "configs/AppConfig";
import { useParams } from "react-router-dom/cjs/react-router-dom";
import chatDetailService from "services/ChatDetailService";
import { createChatDetail, updateChatDetail } from "redux/actions";

const { TabPane } = Tabs;

const ADD = "ADD";
const EDIT = "EDIT";

const DetailChatForm = (props) => {
  const { mode = ADD, param } = props;

  let history = useHistory();
  const { chatId } = useParams();
  const [form] = Form.useForm();
  const dispatch = useDispatch();
  const [submitLoading, setSubmitLoading] = useState(false);
  const [loadingData, setLoadingData] = useState(true);
  const [chatDetailData, setChatData] = useState({});

  useEffect(() => {
    if (mode === EDIT) {
      const { chatId, id } = param;
      chatDetailService.getChatDetail(chatId, id).then((querySnapshot) => {
        setChatData({ ...querySnapshot.data, _id: id });
        form.setFieldsValue({
          title: querySnapshot.data.title,
          sender: querySnapshot.data.sender,
          order: querySnapshot.data.order,
          status: querySnapshot.data.status,
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
      if (values.chatDetail_family_id === undefined)
        values.chatDetail_family_id = "no";
      // if (values.chatDetail_sibling_id === undefined)
      //   values.chatDetail_sibling_id = 'no'

      if (values.status) {
        values.status = "sender";
      } else {
        values.status = "receiver";
      }
      const formData = new FormData();
      if (mode === ADD) {
        for (const key in values) {
          formData.append(key, values[key]);
        }
        const resp = await chatDetailService.addChatDetail(chatId, formData);
        dispatch(createChatDetail(resp.data)); // Assuming the API returns the created news data
        message.success(`Create chat detail with title '${values.title}'`);
        history.push(`/app/chats/detail-chat/${chatId}`);
      } else if (mode === EDIT) {
        for (const key in values) {
          formData.append(key, values[key]);
        }
        const resp = await chatDetailService.updateChatDetail(
          chatId,
          chatDetailData._id,
          formData
        );
        dispatch(updateChatDetail(resp.data)); // Assuming the API returns the updated news data
        message.success(`Chat Detail with title '${values.title}' has updated`);
        history.push(`/app/chats/detail-chat/${chatId}`);
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
                {mode === "ADD" ? "Add Chat" : `Edit Chat`}{" "}
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

export default DetailChatForm;
