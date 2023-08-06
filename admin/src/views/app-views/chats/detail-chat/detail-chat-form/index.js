import React, { useState, useEffect } from 'react'
import PageHeaderAlt from 'components/layout-components/PageHeaderAlt'
import { Tabs, Form, Button, message, Spin } from 'antd'
import Flex from 'components/shared-components/Flex'
import GeneralField from './GeneralField'
import { useDispatch } from 'react-redux'
import { useHistory } from 'react-router-dom'
import { colorPrimary } from 'configs/AppConfig'
import moment from 'moment'
import { useParams } from 'react-router-dom/cjs/react-router-dom'
import { createDetailChat, updateDetailChat } from 'redux/actions'

const { TabPane } = Tabs

const getBase64 = (img, callback) => {
  const reader = new FileReader()
  reader.addEventListener('load', () => callback(reader.result))
  reader.readAsDataURL(img)
}

const ADD = 'ADD'
const EDIT = 'EDIT'

const DetailChatForm = (props) => {
  const { mode = ADD, param } = props

  let history = useHistory()
  const { chatId } = useParams()
  const [form] = Form.useForm()
  const dispatch = useDispatch()
  // const [uploadedImg, setImage] = useState("");
  // const [imageOriginal, setImageOriginal] = useState("");
  // const [uploadLoading, setUploadLoading] = useState(false);
  const [submitLoading, setSubmitLoading] = useState(false)
  const [loadingData, setLoadingData] = useState(true)
  const [chatData, setChatData] = useState({})

  useEffect(() => {
    if (mode === EDIT) {
      const { id } = param
      // FirebaseService.getDetailChatDetail(chatId, id).then((querySnapshot) => {
      //   setChatData({ ...querySnapshot.data(), id: querySnapshot.id })
      //   let status = false
      //   if (querySnapshot.data().status === 'sender') {
      //     status = true
      //   }
      //   form.setFieldsValue({
      //     title: querySnapshot.data().title,
      //     sender: querySnapshot.data().sender,
      //     order: querySnapshot.data().order,
      //     status: status,
      //     date: moment.unix(querySnapshot.data().date),
      //   })
      //   // setImage(querySnapshot.data().downloadUrl);
      //   setLoadingData(false)
      // })
    } else {
      setLoadingData(false)
    }
  }, [form, mode, param, props])

  // const handleUploadChange = (info) => {
  //   setImageOriginal(info.file);
  //   getBase64(info.file.originFileObj, (imageUrl) => {
  //     setImage(imageUrl);
  //     setUploadLoading(true);
  //   });
  // };

  const onFinish = () => {
    setSubmitLoading(true)
    form
      .validateFields()
      .then((values) => {
        setTimeout(async () => {
          if (mode === ADD) {
            // const fileName = `images/chats/${Date.now()}-${imageOriginal.name}`;
            // const fileRef = storage.ref().child(fileName);
            try {
              if (values.chat_family_id === undefined)
                values.chat_family_id = 'no'
              if (values.chat_sibling_id === undefined)
                values.chat_sibling_id = 'no'

              if (values.status) {
                values.status = 'sender'
              } else {
                values.status = 'receiver'
              }
              // const designFile = await fileRef.put(imageOriginal.originFileObj);
              // const downloadUrl = await designFile.ref.getDownloadURL();
              // FirebaseService.addDetailChat(chatId, {
              //   ...values,
              // }).then((resp) => {
              //   dispatch(
              //     createDetailChat({
              //       ...values,
              //     })
              //   )
              //   message.success(`Create chat with name '${values.title}'`)
              //   setSubmitLoading(false)
              //   history.push(`/app/chats/detail-chat/${chatId}`)
              // })
            } catch (e) {
              console.log(e)
            }
          }
          if (mode === EDIT) {
            if (values.chat_family_id === undefined)
              values.chat_family_id = 'no'
            if (values.chat_sibling_id === undefined)
              values.chat_sibling_id = 'no'

            if (values.status) {
              values.status = 'sender'
            } else {
              values.status = 'receiver'
            }
            // FirebaseService.updateDetailChat(chatId, chatData.id, {
            //   ...values,
            // }).then((resp) => {
            //   dispatch(
            //     updateDetailChat({
            //       ...values,
            //     })
            //   )
            //   message.success(`Chat with name '${values.title}' has updated`)
            //   setSubmitLoading(false)
            //   history.push(`/app/chats/detail-chat/${chatId}`)
            // })
          }
        }, 1500)
      })
      .catch((info) => {
        setSubmitLoading(false)
        console.log('info', info)
        message.error('Please enter all required field ')
      })
  }

  const onDiscard = () => {
    history.goBack()
  }

  return (
    <>
      <Form
        layout="vertical"
        form={form}
        name="advanced_search"
        className="ant-advanced-search-form"
        initialValues={{
          heightUnit: 'cm',
          widthUnit: 'cm',
          weightUnit: 'kg',
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
                {mode === 'ADD' ? 'Add Chat' : `Edit Chat`}{' '}
              </h2>
              <div className="mb-3">
                <Button className="mr-2" onClick={() => onDiscard()}>
                  Cancel
                </Button>
                <Button
                  style={{
                    backgroundColor: colorPrimary,
                    color: 'white',
                    border: 'none',
                  }}
                  onClick={() => onFinish()}
                  htmlType="submit"
                  loading={submitLoading}
                >
                  {mode === 'ADD' ? 'Add' : `Save`}
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
                // uploadedImg={uploadedImg}
                // uploadLoading={uploadLoading}
                // handleUploadChange={handleUploadChange}
                />
              )}
            </TabPane>
          </Tabs>
        </div>
      </Form>
    </>
  )
}

export default DetailChatForm
