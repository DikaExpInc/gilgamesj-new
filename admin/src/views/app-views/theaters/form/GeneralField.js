import { Card, Col, Form, Input, Row } from 'antd'
import { useCallback } from 'react'

const GeneralField = (props) => {

  const handleInputChange = useCallback(
    (name, value) => {
      props.setSelectValues((prevValues) => ({
        ...prevValues,
        [name]: value,
      }))
    },
    [props]
  )

	return (
    <>
      <Row gutter={16}>
        <Col xs={24} sm={24} md={24}>
					<Card title='Theater Information'>
						<Form.Item name='name' label='Theater Name'>
              <Input placeholder='Theater Name' />
						</Form.Item>

            <Form.Item name='description' label='Description'>
              <Input placeholder='Description' />
            </Form.Item>

            <Form.Item name='totalSeatRows' label='Seat Rows'>
              <Input placeholder='Seat Rows' type='number' />
            </Form.Item>
					</Card>
				</Col>
			</Row>
		</>
	)
}

export default GeneralField
