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
import { getAllDetailComment } from 'redux/actions'
import { ExclamationCircleOutlined } from '@ant-design/icons'
import { colorPrimary } from 'configs/AppConfig'
import { useParams } from 'react-router-dom/cjs/react-router-dom'

const DetailCommentList = () => {
  const { socialMediaId } = useParams()
  let history = useHistory()
  const chats = useSelector((state) => state.chats)
  const dispatch = useDispatch()
  const [list, setList] = useState([])
  const [selectedRows, setSelectedRows] = useState([])
  const [selectedRowKeys, setSelectedRowKeys] = useState([])

  useEffect(() => {
    // FirebaseService.getDetailComment(socialMediaId)
    //   .then((querySnapshot) => {
    //     let listData = []
    //     querySnapshot.forEach((doc) => {
    //       listData.push({ ...doc.data(), id: doc.id })
    //     })
    //     dispatch(getAllDetailComment(listData))
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

  const addDetailComment = () => {
    history.push(`/app/social-medias/comment/${socialMediaId}/add`)
  }

  const viewDetails = (row) => {
    history.push(`/app/social-medias/comment/${socialMediaId}/${row.id}/edit`)
  }

  const deleteRow = (row) => {
    const objKey = 'id'
    let data = list
    if (selectedRows.length > 1) {
      selectedRows.forEach((elm) => {
        // FirebaseService.deleteChat(elm.id)
        data = utils.deleteArrayRow(data, objKey, elm.id)
        setList(data)
        setSelectedRows([])
      })
    } else {
      // FirebaseService.deleteChat(row.id)
      data = utils.deleteArrayRow(data, objKey, row.id)
      setList(data)
    }
  }

  const tableColumns = [
    {
      title: 'Name',
      dataIndex: 'name',
      sorter: (a, b) => utils.antdTableSorter(a, b, 'name'),
    },
    {
      title: 'Comment',
      dataIndex: 'comment',
      sorter: (a, b) => utils.antdTableSorter(a, b, 'comment'),
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
    const searchArray = e.currentTarget.value ? list : chats
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
            onClick={addDetailComment}
            style={{
              backgroundColor: colorPrimary,
              color: 'white',
              border: 'none',
            }}
            icon={<PlusCircleOutlined />}
            block
          >
            Add Comment
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

export default DetailCommentList
