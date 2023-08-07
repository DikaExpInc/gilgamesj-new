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
import { getAllGalleryVideo } from 'redux/actions'
import { ExclamationCircleOutlined } from '@ant-design/icons'
import { colorPrimary } from 'configs/AppConfig'
import galleryVideoService from 'services/GalleryVideoService'

const GalleryVideoList = () => {
  let history = useHistory()
  const galleryVideos = useSelector((state) => state.galleryVideo.data)
  const dispatch = useDispatch()
  const [list, setList] = useState([])
  const [selectedRows, setSelectedRows] = useState([])
  const [selectedRowKeys, setSelectedRowKeys] = useState([])

  useEffect(() => {
    galleryVideoService
      .getGalleryVideoList()
      .then((querySnapshot) => {
        let listData = []
        querySnapshot.data.forEach((doc) => {
          listData.push({ ...doc, id: doc._id })
        })
        dispatch(getAllGalleryVideo(listData))
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
      onCancel: () => {
        cancel(e)
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

  const addGalleryVideo = () => {
    history.push(`/app/gallery-videos/add-gallery-video`)
  }

  const viewDetails = (row) => {
    history.push(`/app/gallery-videos/edit-gallery-video/${row.id}`)
  }

  const deleteRow = (row) => {
    const objKey = 'id'
    let data = list
    if (selectedRows.length > 1) {
      selectedRows.forEach((elm) => {
        galleryVideoService.deleteGalleryVideo(elm._id)
        data = utils.deleteArrayRow(data, objKey, elm._id)
        setList(data)
        setSelectedRows([])
      })
    } else {
      galleryVideoService.deleteGalleryVideo(row._id)
      data = utils.deleteArrayRow(data, objKey, row._id)
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
    const searchArray = e.currentTarget.value ? list : galleryVideos
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
            onClick={addGalleryVideo}
            style={{
              backgroundColor: colorPrimary,
              color: 'white',
              border: 'none',
            }}
            icon={<PlusCircleOutlined />}
            block
          >
            Add Gallery Video
          </Button>
        </div>
      </Flex>
      <div className="table-responsive">
        <Table
          columns={tableColumns}
          dataSource={list}
          rowKey="_id"
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

export default GalleryVideoList
