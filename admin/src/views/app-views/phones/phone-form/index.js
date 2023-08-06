import React, { useState, useEffect } from 'react'
import PageHeaderAlt from 'components/layout-components/PageHeaderAlt'
import { Tabs, Form, Button, message, Spin } from 'antd'
import Flex from 'components/shared-components/Flex'
import GeneralField from './GeneralField'
import { createPhone, updatePhone } from 'redux/actions'
import { useDispatch } from 'react-redux'
import { useHistory } from 'react-router-dom'
import { colorPrimary } from 'configs/AppConfig'
import moment from 'moment'

const { TabPane } = Tabs

const getBase64 = (img, callback) => {
  const reader = new FileReader()
  reader.addEventListener('load', () => callback(reader.result))
  reader.readAsDataURL(img)
}

const ADD = 'ADD'
const EDIT = 'EDIT'

const PhoneForm = (props) => {
  const { mode = ADD, param } = props

  let history = useHistory()
  const [form] = Form.useForm()
  const dispatch = useDispatch()
  const [uploadedImg, setImage] = useState('')
  const [imageOriginal, setImageOriginal] = useState('')
  const [uploadLoading, setUploadLoading] = useState(false)
  const [uploadedAudio, setAudio] = useState('')
  const [audioOriginal, setAudioOriginal] = useState('')
  const [uploadAudioLoading, setUploadAudioLoading] = useState(false)
  const [submitLoading, setSubmitLoading] = useState(false)
  const [loadingData, setLoadingData] = useState(true)
  const [phoneData, setPhoneData] = useState({})

  useEffect(() => {
    if (mode === EDIT) {
      const { id } = param

      // FirebaseService.getPhoneDetail(id).then((querySnapshot) => {
      //   setPhoneData({ ...querySnapshot.data(), id: querySnapshot.id })
      //   form.setFieldsValue({
      //     name: querySnapshot.data().name,
      //     code: querySnapshot.data().code,
      //   })
      //   setImage(querySnapshot.data().profileUrl)
      //   setAudio(querySnapshot.data().audioUrl)
      //   setLoadingData(false)
      // })
    } else {
      setLoadingData(false)
    }
  }, [form, mode, param, props])

  const handleUploadChange = (info) => {
    setImageOriginal(info.file)
    getBase64(info.file.originFileObj, (imageUrl) => {
      setImage(imageUrl)
      setUploadLoading(true)
    })
  }

  const handleUploadAudioChange = (info) => {
    setAudioOriginal(info.file)
    getBase64(info.file.originFileObj, (audioUrl) => {
      setAudio(audioUrl)
      setUploadAudioLoading(true)
    })
  }

  const onFinish = () => {
    setSubmitLoading(true)
    // form
    //   .validateFields()
    //   .then((values) => {
    //     setTimeout(async () => {
    //       if (mode === ADD) {
    //         const fileName = `images/phones/${Date.now()}-${imageOriginal.name}`
    //         const fileRef = storage.ref().child(fileName)
    //         const audioFileName = `audios/phones/${Date.now()}-${
    //           audioOriginal.name
    //         }`
    //         const audioFileRef = storage.ref().child(audioFileName)
    //         try {
    //           const designFile = await fileRef.put(imageOriginal.originFileObj)
    //           const profileUrl = await designFile.ref.getDownloadURL()
    //           const audioFile = await audioFileRef.put(
    //             audioOriginal.originFileObj
    //           )
    //           const audioUrl = await audioFile.ref.getDownloadURL()
    //           FirebaseService.addPhone({
    //             ...values,
    //             profileUrl,
    //             audioUrl,
    //             date: Date.now(),
    //           }).then((resp) => {
    //             dispatch(
    //               createPhone({
    //                 ...values,
    //                 profileUrl,
    //                 audioUrl,
    //                 date: Date.now(),
    //               })
    //             )
    //             message.success(`Create phone with name '${values.name}'`)
    //             setSubmitLoading(false)
    //             history.push(`/app/phones`)
    //           })
    //         } catch (e) {
    //           console.log(e)
    //         }
    //       }
    //       if (mode === EDIT) {
    //         if (imageOriginal === '') {
    //           values.date = moment(values.date, 'YYYY-MM-DD').valueOf() / 1000
    //           FirebaseService.updatePhone(phoneData.id, {
    //             ...values,
    //             profileUrl: uploadedImg,
    //             audioUrl: uploadedAudio,
    //           }).then((resp) => {
    //             dispatch(
    //               updatePhone({
    //                 ...values,
    //                 profileUrl: uploadedImg,
    //                 audioUrl: uploadedAudio,
    //               })
    //             )
    //             message.success(`Phone with name '${values.name}' has updated`)
    //             setSubmitLoading(false)
    //             history.push(`/app/phones`)
    //           })
    //         } else {
    //           const fileName = `images/phones/${Date.now()}-${
    //             imageOriginal.name
    //           }`
    //           const fileRef = storage.ref().child(fileName)

    //           const audioFileName = `audios/phones/${Date.now()}-${
    //             imageOriginal.name
    //           }`
    //           const audioFileRef = storage.ref().child(audioFileName)
    //           try {
    //             const designFile = await fileRef.put(
    //               imageOriginal.originFileObj
    //             )
    //             const profileUrl = await designFile.ref.getDownloadURL()
    //             const audioFile = await audioFileRef.put(
    //               imageOriginal.originFileObj
    //             )
    //             const audioUrl = await audioFile.ref.getDownloadURL()
    //             FirebaseService.updatePhone(phoneData.id, {
    //               ...values,
    //               profileUrl,
    //               audioUrl,
    //             }).then((resp) => {
    //               dispatch(
    //                 updatePhone({
    //                   ...values,
    //                   profileUrl,
    //                   audioUrl,
    //                 })
    //               )
    //               message.success(
    //                 `Phone with name '${values.name}' has updated`
    //               )
    //               setSubmitLoading(false)
    //               history.push(`/app/phones`)
    //             })
    //           } catch (e) {
    //             console.log(e)
    //           }
    //         }
    //       }
    //     }, 1500)
    //   })
    //   .catch((info) => {
    //     setSubmitLoading(false)
    //     console.log('info', info)
    //     message.error('Please enter all required field ')
    //   })
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
                {mode === 'ADD' ? 'Add Phone' : `Edit Phone`}{' '}
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
                  uploadedImg={uploadedImg}
                  uploadLoading={uploadLoading}
                  handleUploadChange={handleUploadChange}
                  uploadedAudio={uploadedAudio}
                  uploadAudioLoading={uploadAudioLoading}
                  handleUploadAudioChange={handleUploadAudioChange}
                />
              )}
            </TabPane>
          </Tabs>
        </div>
      </Form>
    </>
  )
}

export default PhoneForm
