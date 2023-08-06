import React, { useState, useEffect } from 'react'
import PageHeaderAlt from 'components/layout-components/PageHeaderAlt'
import { Tabs, Form, Button, message, Spin } from 'antd'
import Flex from 'components/shared-components/Flex'
import GeneralField from './GeneralField'
import { createTask, updateTask } from 'redux/actions'
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

const TaskForm = (props) => {
  const { mode = ADD, param } = props

  let history = useHistory()
  const [form] = Form.useForm()
  const dispatch = useDispatch()
  const [uploadedImg, setImage] = useState('')
  const [imageOriginal, setImageOriginal] = useState('')
  const [uploadLoading, setUploadLoading] = useState(false)
  const [submitLoading, setSubmitLoading] = useState(false)
  const [loadingData, setLoadingData] = useState(true)
  const [taskData, setTaskData] = useState({})

  useEffect(() => {
    if (mode === EDIT) {
      const { id } = param

      // FirebaseService.getTaskDetail(id).then((querySnapshot) => {
      //   setTaskData({ ...querySnapshot.data(), id: querySnapshot.id })
      //   form.setFieldsValue({
      //     title: querySnapshot.data().title,
      //     stage_id: querySnapshot.data().stage_id,
      //     description: querySnapshot.data().description,
      //     type: querySnapshot.data().type,
      //     detail_id: querySnapshot.data().detail_id,
      //     is_bonus: querySnapshot.data().is_bonus,
      //     status: querySnapshot.data().status,
      //     date: moment.unix(querySnapshot.data().date),
      //   })
      //   setImage(querySnapshot.data().downloadUrl)
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

  const onFinish = () => {
    setSubmitLoading(true)
    // form
    //   .validateFields()
    //   .then((values) => {
    //     setTimeout(async () => {
    //       if (mode === ADD) {
    //         if (imageOriginal === '') {
    //           try {
    //             FirebaseService.addTask({
    //               ...values,
    //               date: Date.now(),
    //             }).then((resp) => {
    //               dispatch(
    //                 createTask({
    //                   ...values,
    //                   date: Date.now(),
    //                 })
    //               )
    //               message.success(`Create task with title '${values.title}'`)
    //               setSubmitLoading(false)
    //               history.push(`/app/tasks`)
    //             })
    //           } catch (e) {
    //             console.log(e)
    //           }
    //         } else {
    //           const fileName = `images/tasks/${Date.now()}-${
    //             imageOriginal.name
    //           }`
    //           const fileRef = storage.ref().child(fileName)
    //           try {
    //             const designFile = await fileRef.put(
    //               imageOriginal.originFileObj
    //             )
    //             const downloadUrl = await designFile.ref.getDownloadURL()
    //             FirebaseService.addTask({
    //               ...values,
    //               downloadUrl,
    //               date: Date.now(),
    //             }).then((resp) => {
    //               dispatch(
    //                 createTask({
    //                   ...values,
    //                   downloadUrl,
    //                   date: Date.now(),
    //                 })
    //               )
    //               message.success(`Create task with title '${values.title}'`)
    //               setSubmitLoading(false)
    //               history.push(`/app/tasks`)
    //             })
    //           } catch (e) {
    //             console.log(e)
    //           }
    //         }
    //       }
    //       if (mode === EDIT) {
    //         if (imageOriginal === '') {
    //           values.date = moment(values.date, 'YYYY-MM-DD').valueOf() / 1000
    //           FirebaseService.updateTask(taskData.id, {
    //             ...values,
    //             downloadUrl: uploadedImg,
    //           }).then((resp) => {
    //             dispatch(
    //               updateTask({
    //                 ...values,
    //                 downloadUrl: uploadedImg,
    //               })
    //             )
    //             message.success(`Task with title '${values.title}' has updated`)
    //             setSubmitLoading(false)
    //             history.push(`/app/tasks`)
    //           })
    //         } else {
    //           const fileName = `images/tasks/${Date.now()}-${
    //             imageOriginal.name
    //           }`
    //           const fileRef = storage.ref().child(fileName)
    //           try {
    //             const designFile = await fileRef.put(
    //               imageOriginal.originFileObj
    //             )
    //             const downloadUrl = await designFile.ref.getDownloadURL()
    //             FirebaseService.updateTask(taskData.id, {
    //               ...values,
    //               downloadUrl,
    //             }).then((resp) => {
    //               dispatch(
    //                 updateTask({
    //                   ...values,
    //                   downloadUrl,
    //                 })
    //               )
    //               message.success(
    //                 `Task with title '${values.title}' has updated`
    //               )
    //               setSubmitLoading(false)
    //               history.push(`/app/tasks`)
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
                {mode === 'ADD' ? 'Add Task' : `Edit Task`}{' '}
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
                />
              )}
            </TabPane>
          </Tabs>
        </div>
      </Form>
    </>
  )
}

export default TaskForm
