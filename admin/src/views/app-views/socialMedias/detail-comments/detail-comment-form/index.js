import React, { useState, useEffect } from "react";
import PageHeaderAlt from "components/layout-components/PageHeaderAlt";
import { Tabs, Form, Button, message, Spin } from "antd";
import Flex from "components/shared-components/Flex";
import GeneralField from "./GeneralField";
import { createDetailComment, updateDetailComment } from "redux/actions";
import FirebaseService from "services/FirebaseService";
import { useDispatch } from "react-redux";
import { useHistory } from "react-router-dom";
import { storage } from "auth/FirebaseAuth";
import { colorPrimary } from "configs/AppConfig";
import moment from "moment";
import { useParams } from "react-router-dom/cjs/react-router-dom.min";

const { TabPane } = Tabs;

const getBase64 = (img, callback) => {
  const reader = new FileReader();
  reader.addEventListener("load", () => callback(reader.result));
  reader.readAsDataURL(img);
};

const ADD = "ADD";
const EDIT = "EDIT";

const DetailCommentForm = (props) => {
  const { mode = ADD, param } = props;

  let history = useHistory();
  const { socialMediaId } = useParams();
  const [form] = Form.useForm();
  const dispatch = useDispatch();
  const [uploadedImg, setImage] = useState("");
  const [imageOriginal, setImageOriginal] = useState("");
  const [uploadLoading, setUploadLoading] = useState(false);
  const [submitLoading, setSubmitLoading] = useState(false);
  const [loadingData, setLoadingData] = useState(true);
  const [detailCommentData, setDetailCommentData] = useState({});

  useEffect(() => {
    if (mode === EDIT) {
      const { id } = param;

      FirebaseService.getDetailCommentDetail(socialMediaId, id).then(
        (querySnapshot) => {
          setDetailCommentData({
            ...querySnapshot.data(),
            id: querySnapshot.id,
          });
          form.setFieldsValue({
            name: querySnapshot.data().name,
            comment: querySnapshot.data().comment,
          });
          setImage(querySnapshot.data().profileUrl);
          setLoadingData(false);
        }
      );
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
          if (mode === ADD) {
            const fileName = `images/social-medias/comments/${Date.now()}-${
              imageOriginal.name
            }`;
            const fileRef = storage.ref().child(fileName);
            try {
              const designFile = await fileRef.put(imageOriginal.originFileObj);
              const profileUrl = await designFile.ref.getDownloadURL();
              FirebaseService.addDetailComment(socialMediaId, {
                ...values,
                profileUrl,
              }).then((resp) => {
                dispatch(
                  createDetailComment({
                    ...values,
                    profileUrl,
                  })
                );
                message.success(`Create comment with name '${values.name}'`);
                setSubmitLoading(false);
                history.push(`/app/social-medias/comment/${socialMediaId}`);
              });
            } catch (e) {
              console.log(e);
            }
          }
          if (mode === EDIT) {
            if (imageOriginal === "") {
              FirebaseService.updateDetailComment(
                socialMediaId,
                detailCommentData.id,
                {
                  ...values,
                  profileUrl: uploadedImg,
                }
              ).then((resp) => {
                dispatch(
                  updateDetailComment({
                    ...values,
                    profileUrl: uploadedImg,
                  })
                );
                message.success(
                  `Comment with name '${values.name}' has updated`
                );
                setSubmitLoading(false);
                history.push(`/app/social-medias/comment/${socialMediaId}`);
              });
            } else {
              const fileName = `images/social-medias/comments/${Date.now()}-${
                imageOriginal.name
              }`;
              const fileRef = storage.ref().child(fileName);

              try {
                const designFile = await fileRef.put(
                  imageOriginal.originFileObj
                );
                const profileUrl = await designFile.ref.getDownloadURL();
                FirebaseService.updateDetailComment(
                  socialMediaId,
                  detailCommentData.id,
                  {
                    ...values,
                    profileUrl,
                  }
                ).then((resp) => {
                  dispatch(
                    updateDetailComment({
                      ...values,
                      profileUrl,
                    })
                  );
                  message.success(
                    `Comment with name '${values.name}' has updated`
                  );
                  setSubmitLoading(false);
                  history.push(`/app/social-medias/comment/${socialMediaId}`);
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
                {mode === "ADD" ? "Add Comment" : `Edit Comment`}{" "}
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

export default DetailCommentForm;
