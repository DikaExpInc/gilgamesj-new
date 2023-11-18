/* eslint-disable react-hooks/exhaustive-deps */
import React, { useState, useEffect } from 'react'
import { Row, Col, Badge, Card, Button, message } from 'antd'
import DonutChartWidget from 'components/shared-components/DonutChartWidget'
import Flex from 'components/shared-components/Flex'
import { sessionLabels, sessionColor } from './AnalyticDashboardData'
import userService from 'services/UserService'

export const AnalyticDashboard = () => {
  const [sessionData, setSessionData] = useState([])
  const [conbinedSessionData, setCombinedSessionData] = useState([])

  useEffect(() => {
    // Lakukan permintaan API untuk mendapatkan data sesuai kebutuhan Anda
    getUserList()
  }, [])

  const getUserList = () => {
    userService
      .getUserList() // Gantilah dengan metode yang sesuai di userService Anda
      .then((response) => {
        const { data } = response

        console.log(data)

        // Ekstrak data dari respons API sesuai kebutuhan Anda
        const sessionData = data

        // Setel data ke dalam state komponen
        setSessionData(sessionData)

        // Hitung ulang combinedSessionData menggunakan jointSessionData
        const combinedData = jointSessionData(
          [sessionData.length],
          sessionLabels,
          sessionColor
        )
        setCombinedSessionData(combinedData)
      })
      .catch((error) => {
        console.error('Error fetching data from API:', error)
      })
  }

  // Fungsi untuk menggabungkan data sesuai dengan logika yang Anda inginkan
  const jointSessionData = (data, labels, colors) => {
    console.log(data)
    let arr = []
    const dataValue = data
    const label = labels[0]
    const color = colors[0]
    arr = [
      ...arr,
      {
        data: dataValue,
        label: label,
        color: color,
      },
    ]
    return arr
  }

  const deleteUser = () => {
    userService
      .deleteAllUserAndPlayer() // Gantilah dengan metode yang sesuai di userService Anda
      .then((response) => {
        // const { data } = response
        // console.log(data)
        getUserList()
        message.success('User data cleared')
      })
      .catch((error) => {
        console.error('Error fetching data from API:', error)
      })
  }

  return (
    <>
      <Row gutter={16}>
        <Col xs={24} sm={24} md={12} lg={12} xxl={6}>
          <DonutChartWidget
            series={[sessionData.length]}
            labels={sessionLabels}
            title="Sessions Device"
            bodyClass="my-3"
            customOptions={{ colors: sessionColor }}
            extra={
              <Row justify="center">
                <Col xs={20} sm={20} md={20} lg={24}>
                  <div className="mt-4 mx-auto" style={{ maxWidth: 200 }}>
                    {conbinedSessionData.map((elm) => (
                      <Flex
                        alignItems="center"
                        justifyContent="between"
                        className="mb-3"
                        key={elm.label}
                      >
                        <div>
                          <Badge color={elm.color} />
                          <span className="text-gray-light">{elm.label}</span>
                        </div>
                        <span className="font-weight-bold text-dark">
                          {elm.data}
                        </span>
                      </Flex>
                    ))}
                  </div>
                </Col>
              </Row>
            }
          />
        </Col>
        <Col xs={24} sm={24} md={12} lg={12} xxl={6}>
          <Card title="User Setting">
            <div className={`text-center`}>
              <Button onClick={deleteUser}>
                Delete All Player and Remove Session
              </Button>
            </div>
          </Card>
        </Col>
      </Row>
    </>
  )
}

export default AnalyticDashboard
