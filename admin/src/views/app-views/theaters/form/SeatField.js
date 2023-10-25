import React, { useEffect, useState } from 'react'
import { useParams } from 'react-router-dom/cjs/react-router-dom.min'
import theaterService from 'services/TheaterService'

/* eslint-disable jsx-a11y/alt-text */
const {
  Row,
  Col,
  Card,
  Popover,
  Button,
  Select,
  Form,
  message,
} = require('antd')

const { Option } = Select

const SeatFiled = (props) => {
  const { rows } = props
  const [submitLoading, setSubmitLoading] = useState(false)
  const [seatTheater, setSeatTheater] = useState([])
  const [selectedStatus, setSelectedStatus] = useState('default')
  const [visible, setVisible] = useState(false)
  const [activePopover, setActivePopover] = useState(null)
  const { id } = useParams()

  const handleChange = (value) => {
    setSelectedStatus(value)
  }

  const handleVisibleChange = (visible, seatId) => {
    if (visible) {
      setActivePopover(seatId)
    } else {
      setActivePopover(null)
    }
  }

  const [form] = Form.useForm()

  const formItemLayout = {
    labelCol: {
      xs: { span: 24 },
      sm: { span: 8 },
    },
    wrapperCol: {
      xs: { span: 24 },
      sm: { span: 16 },
    },
  }

  const tailFormItemLayout = {
    wrapperCol: {
      xs: {
        span: 24,
        offset: 0,
      },
      sm: {
        span: 16,
        offset: 8,
      },
    },
  }
  const fetchSeats = async () => {
    try {
      const response = await theaterService.getTheaterSeatList(id) // atau endpoint yang benar
      setSeatTheater(response.data)
    } catch (error) {
      console.error('Failed to fetch seats:', error)
    }
  }

  const handleDelete = async (seatId) => {
    try {
      await theaterService.deleteTheaterSeat(seatId, id) // asumsi ada fungsi deleteSeat di theaterService
      fetchSeats()
      message.success(`Seat deleted`)
    } catch (error) {
      message.error(`Failed to delete seat`)
    }
  }

  useEffect(() => {
    fetchSeats()
  }, [])

  const handleSubmit = async (seat, e) => {
    setSubmitLoading(true)
    try {
      console.log(selectedStatus)

      const [row, col] = seat.seatNumber.split('-').map(Number) // Mengkonversi setiap elemen menjadi number

      const newCol = col + 1

      const resp = await theaterService.addSeat(
        {
          name: `${row}-${newCol}`,
          position: selectedStatus,
        },
        id
      )
      fetchSeats()
      setTimeout(() => {
        setSubmitLoading(false)
        message.success(`Seats created`)
        setActivePopover(null)
      }, 1000)
    } catch (error) {
      message.error(`Failed to create theater`)
    }
  }

  const groupedSeats = seatTheater.reduce((acc, seat) => {
    const [row] = seat.seatNumber.split('-')
    if (!acc[row]) {
      acc[row] = []
    }
    acc[row].push(seat)
    return acc
  }, {})

  const content = (index) => {
    return (
      <Form
        {...formItemLayout}
        onSubmit={(e) => handleSubmit(index, e)}
        form={form}
      >
        <Form.Item label="Status">
          <Select
            defaultValue="default"
            style={{ width: 120 }}
            onChange={handleChange}
          >
            <Option value="default">Default</Option>
            <Option value="empty">Empty</Option>
          </Select>
        </Form.Item>
        <Form.Item {...tailFormItemLayout}>
          <Button
            type="primary"
            htmlType="submit"
            onClick={(e) => handleSubmit(index, e)}
          >
            Create
          </Button>
        </Form.Item>
      </Form>
    )
  }

  return (
    <>
      <Row gutter={16}>
        <Col xs={24} sm={24} md={24}>
          <Card title="Theater Seat">
            {Object.values(groupedSeats).map((seatsInRow, rowIndex) => (
              <Row style={{ marginBottom: 10 }} justify="center" key={rowIndex}>
                {seatsInRow.map((seat) => {
                  return seat.position === 'default' ? (
                    <Popover
                      content={
                        <Button
                          type="danger"
                          onClick={() => handleDelete(seat._id)}
                        >
                          Delete
                        </Button>
                      }
                      title="Delete Seat"
                      trigger="click"
                    >
                      <div style={{ textAlign: 'center' }}>
                        {seat.seatNumber}
                      </div>
                      <img
                        key={seat._id}
                        src="/img/seat.png"
                        width={35}
                        height={30}
                      />
                    </Popover>
                  ) : (
                    <Popover
                      content={
                        <Button
                          type="danger"
                          onClick={() => handleDelete(seat._id)}
                        >
                          Delete
                        </Button>
                      }
                      title="Delete Seat"
                      trigger="click"
                    >
                      <div style={{ width: 35, height: 30 }}></div>
                    </Popover>
                  )
                })}
                <Popover
                  content={content(seatsInRow[seatsInRow.length - 1])} // mengambil kursi terakhir di baris sebagai referensi
                  title="Add Seats"
                  trigger="click"
                  visible={
                    activePopover === seatsInRow[seatsInRow.length - 1]._id
                  }
                  onVisibleChange={(vis) =>
                    handleVisibleChange(
                      vis,
                      seatsInRow[seatsInRow.length - 1]._id
                    )
                  }
                >
                  <Button size={'small'} type="primary">
                    +
                  </Button>
                </Popover>
              </Row>
            ))}
          </Card>
        </Col>
      </Row>
    </>
  )
}

export default SeatFiled
