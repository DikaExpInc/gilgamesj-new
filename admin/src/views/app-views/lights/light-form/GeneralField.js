import React, { useCallback, useEffect, useState } from 'react'
import { Input, Row, Col, Card, Form, Select } from 'antd'

const rules = {
  name: [
    {
      required: true,
      message: 'Please fill name',
    },
  ],
  lightArrayList: [
    {
      required: true,
      message: 'Please fill light array',
    },
  ],
}

const GeneralField = (props) => {
  const [lightArray, setLightArray] = useState([])

  const handleInputChange = useCallback(
    (name, value) => {
      props.setSelectValues((prevValues) => ({
        ...prevValues,
        [name]: value,
      }))
    },
    [props]
  )

  useEffect(() => {
    setLightArray([
      {
        value: 1,
        label: 'Red',
      },
      {
        value: 2,
        label: 'Orange',
      },
      {
        value: 3,
        label: 'Yellow',
      },
      {
        value: 4,
        label: 'Green',
      },
      {
        value: 5,
        label: 'Blue',
      },
      {
        value: 6,
        label: 'Purple',
      },
      {
        value: 7,
        label: 'Pink',
      },
      {
        value: 8,
        label: 'Brown',
      },
      {
        value: 9,
        label: 'Black',
      },
      {
        value: 10,
        label: 'Gray',
      },
      {
        value: 11,
        label: 'white',
      },
    ])
  }, [])

  return (
    <Row gutter={16}>
      <Col xs={24} sm={24} md={24}>
        <Card title="Light Information">
          <Form.Item name="name" label="Light Name" rules={rules.name}>
            <Input placeholder="Light Name" />
          </Form.Item>
          <Form.Item
            name="light_array"
            label="Select Light Sequence"
            rules={rules.lightArrayList}
          >
            <Select
              mode="multiple"
              placeholder="Please select"
              style={{ width: '100%' }}
              options={lightArray}
              onChange={(value) =>
                handleInputChange('light_array_selected', value)
              }
              defaultValue={props.lightArrayList}
            />
          </Form.Item>
        </Card>
      </Col>
    </Row>
  )
}

export default GeneralField
