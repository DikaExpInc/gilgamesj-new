import React, { useState } from "react";
import { Row, Col, Card, Form, Select, Slider, Switch } from "antd";
import FirebaseService from "services/FirebaseService";

const rules = {
  page: [
    {
      required: true,
      message: "Please fill name",
    },
  ],
};

const GeneralField = (props) => {
  const [clapValue, setClapValue] = useState(1);
  const [statusFinishClap, setStatusFinishClap] = useState(false);
  const [showSliderClap, setShowSliderClap] = useState(
    props.clapStatus === "clap" ? true : false
  );
  const onChange = (newValue) => {
    setClapValue(newValue);
    FirebaseService.updateSetting("67tjgzl3kIytfIRKV0K5", {
      value_clap: clapValue,
      status_finish: statusFinishClap,
    }).then((resp) => {});
  };
  const onChangeFinish = () => {
    FirebaseService.updateSetting("67tjgzl3kIytfIRKV0K5", {
      value_clap: clapValue,
      status_finish: statusFinishClap,
    }).then((resp) => {});
  };
  const handleChange = (value) => {
    if (value === "clap") {
      setShowSliderClap(true);
    } else {
      setShowSliderClap(false);
    }
  };

  return (
    <Row gutter={16}>
      <Col xs={24} sm={24} md={24}>
        <Card title="Setting Information">
          <Form.Item name="page" label="Game Page" rules={rules.page}>
            <Select
              placeholder="Type Task"
              showSearch
              style={{ width: "100%" }}
              onChange={handleChange}
              options={[
                { value: "main", label: "Main Game" },
                { value: "group", label: "Show Group" },
                { value: "clap", label: "Show Clapping" },
                { value: "performance", label: "Show Performance" },
              ]}
            />
          </Form.Item>
          {showSliderClap ? (
            <>
              <Form.Item
                name="value_clap"
                label="Clapping Percentage"
                rules={rules.value_clap}
              >
                <Slider
                  min={1}
                  max={100}
                  onChange={onChange}
                  value={typeof inputValue === "number" ? clapValue : 0}
                />
              </Form.Item>
              <Form.Item
                name="status_finish"
                label="Clapping Finish Screen"
                rules={rules.value_clap}
              >
                <Switch
                  onChange={onChangeFinish}
                  checkedChildren="Finish"
                  unCheckedChildren="Not Finish Yet"
                />
              </Form.Item>
            </>
          ) : (
            <></>
          )}
        </Card>
      </Col>
    </Row>
  );
};

export default GeneralField;
