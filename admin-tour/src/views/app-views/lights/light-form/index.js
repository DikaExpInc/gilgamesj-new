import React, { useState, useEffect } from 'react'
import PageHeaderAlt from 'components/layout-components/PageHeaderAlt'
import { Tabs, Form, Button, message, Spin } from 'antd'
import Flex from 'components/shared-components/Flex'
import GeneralField from './GeneralField'
import { createLight, updateLight } from 'redux/actions'
import { useDispatch } from 'react-redux'
import { useHistory } from 'react-router-dom'
import { colorPrimary } from 'configs/AppConfig'
import lightService from 'services/LightService'

const { TabPane } = Tabs

const ADD = 'ADD'
const EDIT = 'EDIT'

const LightForm = (props) => {
  const { mode = ADD, param } = props

  let history = useHistory()
  const [form] = Form.useForm()
  const dispatch = useDispatch()
  const [submitLoading, setSubmitLoading] = useState(false)
  const [loadingData, setLoadingData] = useState(true)
  const [lightData, setLightData] = useState({})

  const [lightArrayList, setLightArrayList] = useState([])
  const [selectValues, setSelectValues] = useState({
    light_array_selected: [],
  })

  useEffect(() => {
    if (mode === EDIT) {
      const { id } = param

      lightService.getLight(id).then((querySnapshot) => {
        setLightData({ ...querySnapshot.data, _id: id })
        form.setFieldsValue({
          name: querySnapshot.data.name,
        })
        setLightArrayList(
          querySnapshot.data.data_game.light_array[0].split(',')
        )
        setSelectValues((prevValues) => ({
          ...prevValues,
          light_array_selected:
            querySnapshot.data.data_game.light_array[0].split(','),
        }))
        setLoadingData(false)
      })
    } else {
      setLoadingData(false)
    }
  }, [form, mode, param, props])

  const onFinish = async () => {
    setSubmitLoading(true)
    try {
      const values = await form.validateFields()
      const formData = new FormData()

      if (mode === ADD) {
        for (const key in values) {
          formData.append(key, values[key])
        }

        const resp = await lightService.addLight(formData)
        dispatch(createLight(resp.data)) // Assuming the API returns the created news data
        message.success(`Create light with name '${values.name}'`)
        history.push(`/app/lights`)
      } else if (mode === EDIT) {
        for (const key in values) {
          formData.append(key, values[key])
        }

        const resp = await lightService.updateLight(lightData._id, formData)
        dispatch(updateLight(resp.data)) // Assuming the API returns the updated news data
        message.success(`Light with name '${values.name}' has updated`)
        history.push(`/app/lights`)
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
                {mode === 'ADD' ? 'Add Light' : `Edit Light`}{' '}
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
                  lightArrayList={lightArrayList}
                  setSelectValues={setSelectValues}
                  selectValues={selectValues}
                />
              )}
            </TabPane>
          </Tabs>
        </div>
      </Form>
    </>
  )
}

export default LightForm
