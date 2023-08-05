import React, { useState, useEffect } from "react";
import PageHeaderAlt from "components/layout-components/PageHeaderAlt";
import { Tabs, Form, Button, message, Spin } from "antd";
import Flex from "components/shared-components/Flex";
import GeneralField from "./GeneralField";
import { createSocialMedia, updateSocialMedia } from "redux/actions";
import FirebaseService from "services/FirebaseService";
import { useDispatch } from "react-redux";
import { useHistory } from "react-router-dom";
import { storage } from "auth/FirebaseAuth";
import { colorPrimary } from "configs/AppConfig";
import moment from "moment";

const { TabPane } = Tabs;

const getBase64 = (img, callback) => {
  const reader = new FileReader();
  reader.addEventListener("load", () => callback(reader.result));
  reader.readAsDataURL(img);
};

const ADD = "ADD";
const EDIT = "EDIT";

const SocialMediasForm = (props) => {
  const { mode = ADD, param } = props;

  let history = useHistory();
  const [form] = Form.useForm();
  const dispatch = useDispatch();

  const [uploadedProfileImg, setProfileImage] = useState("");
  const [uploadedImg, setImage] = useState("");

  const [profileImageOriginal, setProfileImageOriginal] = useState("");
  const [imageOriginal, setImageOriginal] = useState("");

  const [profileUploadLoading, setProfileUploadLoading] = useState(false);
  const [uploadLoading, setUploadLoading] = useState(false);
  const [submitLoading, setSubmitLoading] = useState(false);
  const [loadingData, setLoadingData] = useState(true);
  const [socialMediasData, setSocialMediasData] = useState({});

  useEffect(() => {
    if (mode === EDIT) {
      const { id } = param;

      FirebaseService.getSocialMediaDetail(id).then((querySnapshot) => {
        setSocialMediasData({
          ...querySnapshot.data(),
          id: id,
        });
        form.setFieldsValue({
          name: querySnapshot.data().name,
          description: querySnapshot.data().description,
          location: querySnapshot.data().location,
          date: moment.unix(querySnapshot.data().date / 1000),
        });
        setImage(querySnapshot.data().mediaUrl);
        setProfileImage(querySnapshot.data().profileUrl);
        setLoadingData(false);
      });
    } else {
      setLoadingData(false);
    }
  }, [form, mode, param, props]);

  const handleUploadProfileChange = (info) => {
    setProfileImageOriginal(info.file);
    getBase64(info.file.originFileObj, (imageUrl) => {
      setProfileImage(imageUrl);
      setProfileUploadLoading(true);
    });
  };

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
            const fileName = `images/social-medias/medias/${Date.now()}-${
              imageOriginal.name
            }`;
            const fileRef = storage.ref().child(fileName);

            const fileProfileName = `images/social-medias/profiles/${Date.now()}-${
              profileImageOriginal.name
            }`;
            const fileProfileRef = storage.ref().child(fileProfileName);
            try {
              const mediaFile = await fileRef.put(imageOriginal.originFileObj);
              const mediaUrl = await mediaFile.ref.getDownloadURL();

              const profileFile = await fileProfileRef.put(
                profileImageOriginal.originFileObj
              );
              values.date = moment(values.date, "YYYY-MM-DD").valueOf() / 1000;
              const profileUrl = await profileFile.ref.getDownloadURL();
              FirebaseService.addSocialMedia({
                ...values,
                mediaUrl,
                profileUrl,
              }).then((resp) => {
                dispatch(
                  createSocialMedia({
                    ...values,
                    mediaUrl,
                    profileUrl,
                  })
                );
                message.success(
                  `Create socialMedias with name '${values.name}'`
                );
                history.push(`/app/social-medias`);
                setSubmitLoading(false);
              });
            } catch (e) {
              console.log(e);
            }
          }
          if (mode === EDIT) {
            if (imageOriginal === "") {
              values.date = moment(values.date, "YYYY-MM-DD").valueOf() / 1000;
              FirebaseService.updateSocialMedia(socialMediasData.id, {
                ...values,
                mediaUrl: uploadedImg,
                profileUrl: profileImageOriginal,
              }).then((resp) => {
                dispatch(
                  updateSocialMedia({
                    ...values,
                    mediaUrl: uploadedImg,
                    profileUrl: profileImageOriginal,
                  })
                );
                message.success(
                  `SocialMedias with name '${values.name}' has updated`
                );
                setSubmitLoading(false);
                history.push(`/app/social-medias`);
              });
            } else {
              const fileName = `images/social-medias/medias/${Date.now()}-${
                imageOriginal.name
              }`;
              const fileRef = storage.ref().child(fileName);

              const profileName = `images/social-medias/profiles/${Date.now()}-${
                imageOriginal.name
              }`;
              const profileRef = storage.ref().child(profileName);
              try {
                const profileFile = await profileRef.put(
                  profileImageOriginal.originFileObj
                );
                const profileUrl = await profileFile.ref.getDownloadURL();
                values.date =
                  moment(values.date, "YYYY-MM-DD").valueOf() / 1000;
                FirebaseService.updateSocialMedia(socialMediasData.id, {
                  ...values,
                  profileUrl,
                }).then((resp) => {
                  dispatch(
                    updateSocialMedia({
                      ...values,
                      profileUrl,
                    })
                  );
                });

                const designFile = await fileRef.put(
                  imageOriginal.originFileObj
                );
                const mediaUrl = await designFile.ref.getDownloadURL();
                FirebaseService.updateSocialMedia(socialMediasData.id, {
                  ...values,
                  mediaUrl,
                }).then((resp) => {
                  dispatch(
                    updateSocialMedia({
                      ...values,
                      mediaUrl,
                    })
                  );
                  message.success(
                    `SocialMedias with name '${values.name}' has updated`
                  );
                  setSubmitLoading(false);
                  history.push(`/app/social-medias`);
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
                {mode === "ADD" ? "Add Social Medias" : `Edit Social Medias`}{" "}
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
                  profileUploadImg={uploadedProfileImg}
                  profileUploadLoading={profileUploadLoading}
                  handleUploadChange={handleUploadChange}
                  handleUploadProfileChange={handleUploadProfileChange}
                />
              )}
            </TabPane>
          </Tabs>
        </div>
      </Form>
    </>
  );
};

export default SocialMediasForm;
