import React, { useState, useEffect } from 'react'
import PageHeaderAlt from 'components/layout-components/PageHeaderAlt'
import { Tabs, Form, Spin } from 'antd'
import Flex from 'components/shared-components/Flex'
import GeneralField from './GeneralField'
import settingService from 'services/SettingService'
import { useDispatch } from 'react-redux'
import { getSetting } from 'redux/actions'

const { TabPane } = Tabs

const ADD = 'ADD'

const SettingForm = (props) => {
  const { mode = ADD } = props

  const [form] = Form.useForm()

  const [loadingData, setLoadingData] = useState(true)
  const dispatch = useDispatch()

  const [seatsRows, setSeatsRows] = useState(0)
  const [seatsColumns, setSeatsColumns] = useState(0)
  const [ishtarRows, setIshtarRows] = useState(0)

  useEffect(() => {
    settingService
      .getSetting('64de3fd2843badaf9efc006b')
      .then((querySnapshot) => {
        dispatch(getSetting(querySnapshot))
        setLoadingData(false)

        form.setFieldsValue({
          seatsRows: querySnapshot.data.rows,
          seatsColumns: querySnapshot.data.columns,
          ishtarRows: querySnapshot.data.ishtarRows,
          theater: querySnapshot.data.theater_id,
        })

        // Sekarang setelah form.setFieldsValue, kita set nilai state
        setSeatsRows(querySnapshot.data.rows)
        setSeatsColumns(querySnapshot.data.columns)
        setIshtarRows(querySnapshot.data.ishtarRows)
      })
      .catch((error) => {
        console.log('Error getting document:', error)
        setLoadingData(false)
      })
  }, [dispatch, form, seatsRows, seatsColumns, ishtarRows])

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
                {mode === 'ADD' ? 'Add Setting' : `Edit Setting`}{' '}
              </h2>
            </Flex>
          </div>
        </PageHeaderAlt>
        <div className="container">
          <Tabs defaultActiveKey="1" style={{ marginTop: 30 }}>
            <TabPane tab="General" key="1">
              {loadingData && <Spin size="large" tip="Please Wait" />}
              {!loadingData && (
                <GeneralField
                  seatsRows={seatsRows}
                  seatsColumns={seatsColumns}
                  ishtarRows={ishtarRows}
                />
              )}
            </TabPane>
          </Tabs>
        </div>
      </Form>
    </>
  )
}

export default SettingForm
