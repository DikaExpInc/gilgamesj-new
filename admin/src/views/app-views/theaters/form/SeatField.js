import { useEffect } from 'react'
import theaterService from 'services/TheaterService'

const { Row, Col, Card } = require('antd')

const SeatFiled = (props) => {

  const { param } = props

  console.log(param);

  // useEffect(() => {
  //   theaterService
  //     .getTheater(param.id)
  //     .then((querySnapshot) => {
  //       const data = querySnapshot.data
  //       setStatus_stage(data.status)
  //       form.setFieldsValue({
  //         name: data.name,
  //         description: data.description,
  //         totalSeatRows: data.totalSeatRows,
  //       })
  //       setLoadingData(false)
  //     })
  //     .catch((error) => {
  //       console.log('Error getting document:', error)
  //     })
  // }, [])
  return (
    <>
      <Row gutter={16}>
        <Col xs={24} sm={24} md={24}>
          <Card title="Theater Seat"></Card>


        </Col>
      </Row>
    </>
  )
}

export default SeatFiled
