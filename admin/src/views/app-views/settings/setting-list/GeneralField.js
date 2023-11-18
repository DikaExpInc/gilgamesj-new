import React, { useEffect, useState } from 'react'
import { Row, Col, Card, Form, Button, message, InputNumber } from 'antd'
import { colorPrimary } from 'configs/AppConfig'
import settingService from 'services/SettingService'

const GeneralField = (props) => {
  const [submitLoading, setSubmitLoading] = useState(false)
  const [seatsRows, setSeatsRows] = useState(props.seatsRows || 0)
  const [seatsColumns, setSeatsColumns] = useState(props.seatsColumns || 0)
  const [ishtarRows, setIshtarRows] = useState(props.ishtarRows || 0)

  useEffect(() => {
    setSeatsRows(props.seatsRows)
    setSeatsColumns(props.seatsColumns)
    setIshtarRows(props.ishtarRows)
  }, [props])

  const onFinishSeats = () => {
    setSubmitLoading(true)
    const seatsData = {
      rows: seatsRows,
      columns: seatsColumns,
    }
    settingService
      .updateSettingSeats('64de3fd2843badaf9efc006b', seatsData)
      .then(() => {
        message.success(`Seats has updated`)
        setSubmitLoading(false)
      })
      .catch((error) => {
        console.log('Error updating seats settings:', error)
        setSubmitLoading(false)
      })
  }

  const onFinishSeatsIshtar = () => {
    setSubmitLoading(true)
    const ishtarData = {
      rows: ishtarRows,
    }
    // Ganti settingService.updateSettingIshtar dengan fungsi yang sesuai
    settingService
      .updateSettingSeatsIshtar('64de3fd2843badaf9efc006b', ishtarData)
      .then(() => {
        message.success(`Ishtar Game Call has updated`)
        setSubmitLoading(false)
      })
      .catch((error) => {
        console.log('Error updating Ishtar settings:', error)
        setSubmitLoading(false)
      })
  }

  return (
    <Row gutter={16}>
      <Col xs={24} sm={24} md={24}>
        <Card title="Seats Number Global Information">
          <Row gutter={16}>
            <Col>
              <Form.Item
                name="seatsRows"
                label="Columns Theater (Seats max: 18)"
                onChange={(e) => setSeatsRows(e.target.value)}
              >
                <InputNumber placeholder="Rows theater" max={18} min={1} />
              </Form.Item>
            </Col>
            <Col>
              <Form.Item
                name="seatsColumns"
                label="Rows Theater (Seats max: 12)"
                onChange={(e) => setSeatsColumns(e.target.value)}
              >
                <InputNumber placeholder="Columns theater" max={12} min={1} />
              </Form.Item>
            </Col>
          </Row>
          <Button
            style={{
              backgroundColor: colorPrimary,
              color: 'white',
              border: 'none',
            }}
            onClick={() => onFinishSeats()}
            htmlType="submit"
            loading={submitLoading}
          >
            Save Seats
          </Button>
        </Card>
        <Card title="Seats Call Ishtar Information">
          <Row gutter={16}>
            <Col>
              <Form.Item
                name="ishtarRows"
                label="Rows Theater (Ishtar)"
                onChange={(e) => setIshtarRows(e.target.value)}
              >
                <InputNumber placeholder="Rows theater" max={12} min={1} />
              </Form.Item>
            </Col>
          </Row>
          <Button
            style={{
              backgroundColor: colorPrimary,
              color: 'white',
              border: 'none',
            }}
            onClick={() => onFinishSeatsIshtar()}
            htmlType="submit"
            loading={submitLoading}
          >
            Save Ishtar
          </Button>
        </Card>
      </Col>
    </Row>
  )
}

export default GeneralField
