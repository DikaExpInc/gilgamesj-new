import React, { useEffect, useState } from 'react'
import { Card, Table, Input, Menu, message, Modal } from 'antd'
import { EyeOutlined, DeleteOutlined, SearchOutlined } from '@ant-design/icons'
import EllipsisDropdown from 'components/shared-components/EllipsisDropdown'
import Flex from 'components/shared-components/Flex'
import { useHistory } from 'react-router-dom'
import utils from 'utils'
import { useDispatch, useSelector } from 'react-redux'
import { getAllPlayer } from 'redux/actions'
import { ExclamationCircleOutlined } from '@ant-design/icons'
import playerService from 'services/PlayerService'

const PlayerList = () => {
  let history = useHistory()
  const players = useSelector((state) => state.players)
  const dispatch = useDispatch()
  const [list, setList] = useState([])
  const [selectedRows, setSelectedRows] = useState([])
  const [selectedRowKeys, setSelectedRowKeys] = useState([])

  useEffect(() => {
    playerService
      .getPlayerList()
      .then((querySnapshot) => {
        console.log(querySnapshot)
        let listData = []
        querySnapshot.data.forEach((doc) => {
          listData.push({ ...doc, id: doc._id })
        })

        dispatch(getAllPlayer(listData))
        setList(listData)
      })
      .catch((error) => {
        console.log('Error getting document:', error)
      })
  }, [dispatch])

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
    message.error('Canceled')
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
  const viewDetails = (row) => {
    history.push(`/app/players/edit-player/${row.id}`)
  }
  const deleteRow = (row) => {
    const objKey = 'id'
    let data = list
    if (selectedRows.length > 1) {
      selectedRows.forEach((elm) => {
        playerService.deletePlayer(elm._id)
        data = utils.deleteArrayRow(data, objKey, elm._id)
        setList(data)
        setSelectedRows([])
      })
    } else {
      playerService.deletePlayer(row._id)
      data = utils.deleteArrayRow(data, objKey, row._id)
      setList(data)
    }
  }

  const tableColumns = [
    {
      title: 'Name',
      dataIndex: 'username',
      sorter: (a, b) => utils.antdTableSorter(a, b, 'username'),
    },
    {
      title: 'Position',
      dataIndex: 'position',
      sorter: (a, b) => utils.antdTableSorter(a, b, 'position'),
    },
    {
      title: 'Rij',
      dataIndex: 'rij',
      sorter: (a, b) => utils.antdTableSorter(a, b, 'rij'),
    },
    {
      title: 'Stoel',
      dataIndex: 'stoel',
      sorter: (a, b) => utils.antdTableSorter(a, b, 'stoel'),
    },
    {
      title: 'Seat',
      dataIndex: 'status_seat',
      sorter: (a, b) => utils.antdTableSorter(a, b, 'status_seat'),
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
    const searchArray = e.currentTarget.value ? list : players
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

export default PlayerList
