import React, { useEffect, useState } from "react";
import { Card, Table, Input, Button, Menu, message, Modal } from "antd";
import {
  EyeOutlined,
  DeleteOutlined,
  SearchOutlined,
  PlusCircleOutlined,
} from "@ant-design/icons";
import EllipsisDropdown from "components/shared-components/EllipsisDropdown";
import Flex from "components/shared-components/Flex";
import { useHistory } from "react-router-dom";
import utils from "utils";
import FirebaseService from "services/FirebaseService";
import { useDispatch, useSelector } from "react-redux";
import { getAllNews } from "redux/actions";
import { ExclamationCircleOutlined } from "@ant-design/icons";
import { colorPrimary } from "configs/AppConfig";

const NewsList = () => {
  let history = useHistory();
  const news = useSelector((state) => state.news);
  const dispatch = useDispatch();
  const [list, setList] = useState([]);
  const [selectedRows, setSelectedRows] = useState([]);
  const [selectedRowKeys, setSelectedRowKeys] = useState([]);

  useEffect(() => {
    FirebaseService.getNews()
      .then((querySnapshot) => {
        let listData = [];
        querySnapshot.forEach((doc) => {
          listData.push({ ...doc.data(), id: doc.id });
        });
        dispatch(getAllNews(listData));
        setList(listData);
      })
      .catch((error) => {
        console.log("Error getting document:", error);
      });
  }, []);

  const confirm = (e) => {
    Modal.confirm({
      title: "Warning",
      icon: <ExclamationCircleOutlined />,
      content: "Are you really wanna delete this data ?",
      okText: "Delete",
      cancelText: "Cancel",
      onOk: () => {
        deleteRow(e);
      },
    });
  };

  const cancel = (e) => {
    message.error("Tidak jadi dihapus");
  };

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
              : "Delete"}
          </span>
        </Flex>
      </Menu.Item>
    </Menu>
  );

  const addNews = () => {
    history.push(`/app/news/add-news`);
  };

  const viewDetails = (row) => {
    history.push(`/app/news/edit-news/${row.id}`);
  };

  const deleteRow = (row) => {
    const objKey = "id";
    let data = list;
    if (selectedRows.length > 1) {
      selectedRows.forEach((elm) => {
        FirebaseService.deleteNews(elm.id);
        data = utils.deleteArrayRow(data, objKey, elm.id);
        setList(data);
        setSelectedRows([]);
      });
    } else {
      FirebaseService.deleteNews(row.id);
      data = utils.deleteArrayRow(data, objKey, row.id);
      setList(data);
    }
  };

  const tableColumns = [
    {
      title: "Title",
      dataIndex: "title",
      sorter: (a, b) => utils.antdTableSorter(a, b, "title"),
    },
    {
      title: "Description",
      dataIndex: "description",
      sorter: (a, b) => utils.antdTableSorter(a, b, "title"),
    },
    {
      title: "",
      dataIndex: "actions",
      render: (_, elm) => (
        <div className="text-right">
          <EllipsisDropdown menu={dropdownMenu(elm)} />
        </div>
      ),
    },
  ];

  const rowSelection = {
    onChange: (key, rows) => {
      setSelectedRows(rows);
      setSelectedRowKeys(key);
    },
  };

  const onSearch = (e) => {
    const value = e.currentTarget.value;
    const searchArray = e.currentTarget.value ? list : news;
    const data = utils.wildCardSearch(searchArray, value);
    setList(data);
    setSelectedRowKeys([]);
  };

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
            style={{
              backgroundColor: colorPrimary,
              color: "white",
              border: "none",
            }}
            onClick={addNews}
            icon={<PlusCircleOutlined />}
            block
          >
            Add News
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
            type: "checkbox",
            preserveSelectedRowKeys: false,
            ...rowSelection,
          }}
        />
      </div>
    </Card>
  );
};

export default NewsList;
