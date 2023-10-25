import { Tabs, Form, Button, message, Spin } from 'antd'
import PageHeaderAlt from 'components/layout-components/PageHeaderAlt'
import Flex from 'components/shared-components/Flex'
import { colorPrimary } from 'configs/AppConfig'
import { useEffect, useState } from 'react'
import { useDispatch } from 'react-redux'
import { useHistory } from 'react-router-dom/cjs/react-router-dom.min'
import GeneralField from './GeneralField'
import theaterService from 'services/TheaterService'
import { createTheater } from 'redux/actions/Theater'
import SeatFiled from './SeatField'

const { TabPane } = Tabs

const ADD = 'ADD'
const EDIT = 'EDIT'

const FormComponent = (props) => {
  const { mode = ADD, param } = props
  let history = useHistory()
  const [form] = Form.useForm()
  const dispatch = useDispatch()

  const [submitLoading, setSubmitLoading] = useState(false)
  const [loadingData, setLoadingData] = useState(true)
  const [status_stage, setStatus_stage] = useState(true)
  const [rows, setRows] = useState(0)

  const onDiscard = () => {
    history.goBack()
  }

  useEffect(() => {
    if (mode === EDIT) {
      theaterService
        .getTheater(param.id)
        .then((querySnapshot) => {
          const data = querySnapshot.data
          setStatus_stage(data.status)
          form.setFieldsValue({
            name: data.name,
            description: data.description,
            totalSeatRows: data.totalSeatRows,
          })
          setRows(data.totalSeatRows)
          setLoadingData(false)
        })
        .catch((error) => {
          console.log('Error getting document:', error)
        })
    } else {
      setLoadingData(false)
    }
  }, [form, mode, param, props])

  const handleSave = async () => {
    setSubmitLoading(true)
    try {
      const values = await form.validateFields()
      const formData = new FormData()

      if (mode === ADD) {
        for (const key in values) {
          formData.append(key, values[key])
        }

        const resp = await theaterService.addTheater(formData)
        setTimeout(() => {
          setSubmitLoading(false)
          dispatch(createTheater(resp.data))
          message.success(`Theater '${values.name}' created`)
          history.push(`/app/theaters/list`)
        }, 1000)
      }
    } catch (error) {
      message.error(`Failed to create theater`)
    }
  }

  return (
    <>
      <Form
        layout="vertical"
        form={form}
        name="advanced_search"
        className="ant-advanced-search-form"
        initialValues={{
          status: status_stage,
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
                {mode === 'ADD' ? 'Add Stage' : `Edit Stage`}{' '}
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
                  onClick={handleSave}
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
              {!loadingData && <GeneralField />}
            </TabPane>
            {mode === 'EDIT' && (
              <TabPane tab="Seat" key="2">
                {loadingData && <Spin size="large" tip="Please Wait" />}
                {!loadingData && <SeatFiled rows={rows} />}
              </TabPane>
            )}
          </Tabs>
        </div>
      </Form>
    </>
  )
}

export default FormComponent
