/* eslint-disable no-unused-vars */
import { Button, Card, Menu, Modal, Table } from 'antd'
import {
  // SearchOutlined,
  PlusCircleOutlined,
  EyeOutlined,
  DeleteOutlined,
  ExclamationCircleOutlined,
} from '@ant-design/icons'
import Flex from 'components/shared-components/Flex'
import { colorPrimary } from 'configs/AppConfig'
import { useHistory } from 'react-router-dom'
import { useDispatch, useSelector } from 'react-redux'
import { useEffect, useState } from 'react'
import utils from 'utils'
import EllipsisDropdown from 'components/shared-components/EllipsisDropdown'
import theaterService from 'services/TheaterService'
import { getAllTheater } from 'redux/actions/Theater'

const TheaterList = () => {
  let history = useHistory()
  const theaters = useSelector((state) => state.theaters)
  const dispatch = useDispatch()
  const [list, setList] = useState([])
  const [selectedRows, setSelectedRows] = useState([])
  const [selectedRowKeys, setSelectedRowKeys] = useState([])

  useEffect(() => {
    theaterService
      .getTheaterList()
      .then((querySnapshot) => {
        let listData = []
        querySnapshot.data.forEach((doc) => {
          listData.push({ ...doc, id: doc._id })
        })

        dispatch(getAllTheater(listData))
        setList(listData)
      })
      .catch((error) => {
        console.log('Error getting document:', error)
      })
  }, [dispatch])

  const addData = () => {
    history.push(`/app/theaters/add`)
  }

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

  // const cancel = (e) => {
  // 	message.error('Canceled')
  // }

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
    history.push(`/app/theaters/edit/${row.id}`)
  }

  const deleteRow = (row) => {
    const objKey = 'id'
    let data = list
    if (selectedRows.length > 1) {
      selectedRows.forEach((elm) => {
        theaterService.deleteTheater(elm._id)
        data = utils.deleteArrayRow(data, objKey, elm._id)
        setList(data)
        setSelectedRows([])
      })
    } else {
      theaterService.deleteTheater(row._id)
      data = utils.deleteArrayRow(data, objKey, row._id)
      setList(data)
    }
  }

  // const onSearch = (e) => {
  // 	const value = e.currentTarget.value
  // 	const searchArray = e.currentTarget.value ? list : theaters
  // 	const data = utils.wildCardSearch(searchArray, value)
  // 	setList(data)
  // 	setSelectedRowKeys([])
  // }

  const tableColumns = [
    {
      title: 'Name',
      dataIndex: 'name',
      sorter: (a, b) => utils.antdTableSorter(a, b, 'name'),
    },
    {
      title: 'Total Seat Rows',
      dataIndex: 'totalSeatRows',
      sorter: (a, b) => utils.antdTableSorter(a, b, 'totalSeatRows'),
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

  return (
    <Card>
      <Flex alignItems="center" justifyContent="between" mobileFlex={false}>
        <Flex className="mb-1" mobileFlex={false}>
          {/* <div className='mr-md-3 mb-3'>
						<Input
							placeholder='Search'
							prefix={<SearchOutlined />}
							onChange={(e) => onSearch(e)}
						/>
					</div> */}
        </Flex>
        <div>
          <Button
            onClick={addData}
            style={{
              backgroundColor: colorPrimary,
              color: 'white',
              border: 'none',
            }}
            icon={<PlusCircleOutlined />}
            block
          >
            Add Theater
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
export default TheaterList
