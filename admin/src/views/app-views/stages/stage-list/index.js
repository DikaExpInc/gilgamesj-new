import React, { useEffect, useState } from 'react'
import { Card, Table, Input, Button, Menu, message, Modal } from 'antd'
import {
  EyeOutlined,
  DeleteOutlined,
  SearchOutlined,
  PlusCircleOutlined,
} from '@ant-design/icons'
import EllipsisDropdown from 'components/shared-components/EllipsisDropdown'
import Flex from 'components/shared-components/Flex'
import { useHistory } from 'react-router-dom'
import utils from 'utils'
import { useDispatch, useSelector } from 'react-redux'
import { getAllStage } from 'redux/actions'
import { ExclamationCircleOutlined } from '@ant-design/icons'
import { colorPrimary } from 'configs/AppConfig'
import moment from 'moment'

const StageList = () => {
  let history = useHistory()
  const stages = useSelector((state) => state.stages)
  const dispatch = useDispatch()
  const [list, setList] = useState([])
  const [selectedRows, setSelectedRows] = useState([])
  const [selectedRowKeys, setSelectedRowKeys] = useState([])

  useEffect(() => {
    // FirebaseService.getStage()
    //   .then((querySnapshot) => {
    //     let listData = []
    //     querySnapshot.forEach((doc) => {
    //       listData.push({ ...doc.data(), id: doc.id })
    //     })
    //     dispatch(getAllStage(listData))
    //     setList(listData)
    //   })
    //   .catch((error) => {
    //     console.log('Error getting document:', error)
    //   })
  }, [])

  const confirm = (e) => {
    Modal.confirm({
      title: 'Warning',
      icon: <ExclamationCircleOutlined />,
      content: 'Are you really wanna delete this data ?',
      okText: 'Delete',
      cancelText: 'Cancel',
      onOk: () => {
        deleteRow(e)
      },
    })
  }

  const cancel = (e) => {
    message.error('Tidak jadi dihapus')
  }

  const dropdownMenu = (row) => (
    <Menu>
      <Menu.Item onClick={() => viewDetails(row)}>
        <Flex alignItems="center">
          <EyeOutlined />
          <span className="ml-2">View Details</span>
        </Flex>
      </Menu.Item>

      <Menu.Item key={5} onClick={() => confirm(row)}>
        <Flex alignItems="center">
          <DeleteOutlined />
          <span className="ml-2">
            {selectedRows.length > 0
              ? `Delete (${selectedRows.length})`
              : 'Delete'}
          </span>
        </Flex>
      </Menu.Item>
    </Menu>
  )

  const addStage = () => {
    history.push(`/app/stages/add-stage`)
  }

  const viewDetails = (row) => {
    history.push(`/app/stages/edit-stage/${row.id}`)
  }

  const deleteRow = (row) => {
    const objKey = 'id'
    let data = list
    if (selectedRows.length > 1) {
      selectedRows.forEach((elm) => {
        // FirebaseService.deleteStage(elm.id)
        data = utils.deleteArrayRow(data, objKey, elm.id)
        setList(data)
        setSelectedRows([])
      })
    } else {
      // FirebaseService.deleteStage(row.id)
      data = utils.deleteArrayRow(data, objKey, row.id)
      setList(data)
    }
  }

  const tableColumns = [
    {
      title: 'Title',
      dataIndex: 'title',
      sorter: (a, b) => utils.antdTableSorter(a, b, 'title'),
    },
    {
      title: 'Date',
      dataIndex: 'date',
      sorter: (a, b) => utils.antdTableSorter(a, b, 'date'),
      render: (date) => moment.unix(date / 1000),
    },
    {
      title: '',
      dataIndex: 'actions',
      render: (_, elm) => (
        <div className="text-right">
          <EllipsisDropdown menu={dropdownMenu(elm)} />
        </div>
      ),
    },
  ]

  const rowSelection = {
    onChange: (key, rows) => {
      setSelectedRows(rows)
      setSelectedRowKeys(key)
    },
  }

  const onSearch = (e) => {
    const value = e.currentTarget.value
    const searchArray = e.currentTarget.value ? list : stages
    const data = utils.wildCardSearch(searchArray, value)
    setList(data)
    setSelectedRowKeys([])
  }

  return (
    <Card>
      <Flex alignItems="center" justifyContent="between" mobileFlex={false}>
        <Flex className="mb-1" mobileFlex={false}>
          <div className="mr-md-3 mb-3">
            <Input
              placeholder="Search"
              prefix={<SearchOutlined />}
              onChange={(e) => onSearch(e)}
            />
          </div>
        </Flex>
        <div>
          <Button
            onClick={addStage}
            style={{
              backgroundColor: colorPrimary,
              color: 'white',
              border: 'none',
            }}
            icon={<PlusCircleOutlined />}
            block
          >
            Add Stage
          </Button>
        </div>
      </Flex>
      <div className="table-responsive">
        <Table
          columns={tableColumns}
          dataSource={list}
          rowKey="id"
          rowSelection={{
            selectedRowKeys: selectedRowKeys,
            type: 'checkbox',
            preserveSelectedRowKeys: false,
            ...rowSelection,
          }}
        />
      </div>
    </Card>
  )
}

export default StageList
