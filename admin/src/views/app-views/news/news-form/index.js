import React, { useState, useEffect } from "react";
import PageHeaderAlt from "components/layout-components/PageHeaderAlt";
import { Tabs, Form, Button, message, Spin, Row, Col } from "antd";
import Flex from "components/shared-components/Flex";
import GeneralField from "./GeneralField";
import { createNews, updateNews } from "redux/actions";
import FirebaseService from "services/FirebaseService";
import { useDispatch, useSelector } from "react-redux";
import { useHistory } from "react-router-dom";
import { storage } from "auth/FirebaseAuth";
import newsService from "services/NewsService";

const { TabPane } = Tabs;

const getBase64 = (img, callback) => {
  const reader = new FileReader();
  reader.addEventListener("load", () => callback(reader.result));
  reader.readAsDataURL(img);
};

const ADD = "ADD";
const EDIT = "EDIT";

const NewsForm = (props) => {
  const { mode = ADD, param } = props;

  let history = useHistory();
  const [form] = Form.useForm();
  const news = useSelector((state) => state.news);
  const dispatch = useDispatch();
  const [uploadedImg, setImage] = useState("");
  const [imageOriginal, setImageOriginal] = useState("");
  const [uploadLoading, setUploadLoading] = useState(false);
  const [submitLoading, setSubmitLoading] = useState(false);
  const [loadingData, setLoadingData] = useState(true);
  const [newsData, setNewsData] = useState({});

  useEffect(() => {
    if (mode === EDIT) {
      const { id } = param;
      const costId = parseInt(id);
      const datas = news.data.filter((data) => data.id === costId);
      form.setFieldsValue({
        title: datas[0].attributes.title,
        description: datas[0].attributes.description,
        category: datas[0].attributes.category,
      });
      setImage(datas[0].attributes.image);
      setLoadingData(false);
    } else {
      setLoadingData(false);
    }
  }, [form, mode, param, props]);

  const handleUploadChange = (info) => {
    setImageOriginal(info.file);
    getBase64(info.file.originFileObj, (imageUrl) => {
      setImage(imageUrl);
      setUploadLoading(true);
    });
  };

  const onFinish = () => {
    setSubmitLoading(true);
    form
      .validateFields()
      .then((values) => {
        setTimeout(async () => {
          setSubmitLoading(false);
          if (mode === ADD) {
            const fileName = `images/news/${Date.now()}-${imageOriginal.name}`;
            const fileRef = storage.ref().child(fileName);
            try {
              const designFile = await fileRef.put(imageOriginal.originFileObj);
              const downloadUrl = await designFile.ref.getDownloadURL();

              newsService
                .addBrowser({
                  ...values,
                  downloadUrl,
                  date: Date.now(),
                })
                .then((resp) => {
                  dispatch(
                    createNews({ ...values, downloadUrl, date: Date.now() })
                  );
                  message.success(`Create news with title '${values.title}'`);
                  history.push(`/app/news`);
                });
            } catch (e) {
              console.log(e);
            }
          }
          if (mode === EDIT) {
            if (imageOriginal === "") {
              FirebaseService.updateNews(newsData.id, {
                ...values,
                downloadUrl: uploadedImg,
              }).then((resp) => {
                dispatch(
                  updateNews({
                    ...values,
                    downloadUrl: uploadedImg,
                  })
                );
                message.success(
                  `News with title '${values.title}' has updated`
                );
                history.push(`/app/news`);
              });
            } else {
              const fileName = `images/news/${Date.now()}-${
                imageOriginal.name
              }`;
              const fileRef = storage.ref().child(fileName);
              try {
                const designFile = await fileRef.put(
                  imageOriginal.originFileObj
                );
                const downloadUrl = await designFile.ref.getDownloadURL();
                FirebaseService.updateNews(newsData.id, {
                  ...values,
                  downloadUrl,
                }).then((resp) => {
                  dispatch(
                    updateNews({
                      ...values,
                      downloadUrl,
                    })
                  );
                  message.success(
                    `News with title '${values.title}' has updated`
                  );
                  history.push(`/app/news`);
                });
              } catch (e) {
                console.log(e);
              }
            }
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
                {mode === "ADD" ? "Add News" : `Edit News`}{" "}
              </h2>
              <div className="mb-3">
                <Button className="mr-2" onClick={() => onDiscard()}>
                  Cancel
                </Button>
                <Button
                  type="primary"
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
              {!loadingData && (
                <GeneralField
                  uploadedImg={uploadedImg}
                  uploadLoading={uploadLoading}
                  handleUploadChange={handleUploadChange}
                />
              )}
            </TabPane>
          </Tabs>
        </div>
      </Form>
    </>
  );
};

export default NewsForm;
