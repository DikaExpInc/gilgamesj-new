import React, { useState, useEffect } from 'react'
import PageHeaderAlt from 'components/layout-components/PageHeaderAlt'
import { Tabs, Form, Button, message, Spin } from 'antd'
import Flex from 'components/shared-components/Flex'
import GeneralField from './GeneralField'
import { createTask, updateTask } from 'redux/actions'
import { useDispatch } from 'react-redux'
import { useHistory } from 'react-router-dom'
import { colorPrimary } from 'configs/AppConfig'
import taskService from 'services/TaskService'
import { useParams } from 'react-router-dom/cjs/react-router-dom.min'

const { TabPane } = Tabs

const ADD = 'ADD'
const EDIT = 'EDIT'

const TaskForm = (props) => {
  const { mode = ADD, param } = props

  let history = useHistory()
  const [form] = Form.useForm()
  const dispatch = useDispatch()
  const [submitLoading, setSubmitLoading] = useState(false)
  const [loadingData, setLoadingData] = useState(true)
  const [taskData, setTaskData] = useState({})
  const { stageId } = useParams()

  useEffect(() => {
    if (mode === EDIT) {
      const { id } = param

      taskService.getTask(stageId, id).then((querySnapshot) => {
        setTaskData({ ...querySnapshot.data, _id: id })
        form.setFieldsValue({
          title: querySnapshot.data.title,
          description: querySnapshot.data.description,
          type: querySnapshot.data.type,
          detail_id: querySnapshot.data.detail_id,
        })
        setLoadingData(false)
      })
    } else {
      setLoadingData(false)
    }
  }, [form, mode, param, props, stageId])

  const onFinish = async () => {
    setSubmitLoading(true)
    try {
      const values = await form.validateFields()
      const formData = new FormData()

      if (mode === ADD) {
        formData.append('stage_id', stageId)
        for (const key in values) {
          formData.append(key, values[key])
        }

        const resp = await taskService.addTask(stageId, formData)
        dispatch(createTask(resp.data)) // Assuming the API returns the created news data
        message.success(`Create task with title '${values.title}'`)
        history.push(`/app/stages/detail-task/${stageId}`)
      } else if (mode === EDIT) {
        formData.append('stage_id', stageId)
        for (const key in values) {
          formData.append(key, values[key])
        }

        const resp = await taskService.updateTask(
          stageId,
          taskData._id,
          formData
        )
        dispatch(updateTask(resp.data)) // Assuming the API returns the updated news data
        message.success(`News with title '${values.title}' has updated`)
        history.push(`/app/stages/detail-task/${stageId}`)
      }
    } catch (error) {
      setSubmitLoading(false)
      console.log('Error:', error)
      message.error('An error occurred. Please try again later.')
    }
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
              {!loadingData && <GeneralField form={form} />}
            </TabPane>
          </Tabs>
        </div>
      </Form>
    </>
  )
}

export default TaskForm
