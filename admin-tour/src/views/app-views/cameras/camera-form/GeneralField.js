import React from "react";
import { Input, Row, Col, Card, Form } from "antd";

const rules = {
  name: [
    {
      required: true,
      message: "Please fill name",
    },
  ],
  code: [
    {
      required: true,
      message: "Please fill code",
    },
  ],
  url: [
    {
      required: true,
      message: "Please fill URL",
    },
  ],
};

const GeneralField = (props) => (
  <Row gutter={16}>
    <Col xs={24} sm={24} md={24}>
      <Card title="Camera Information">
        <Form.Item name="name" label="Camera Name" rules={rules.name}>
          <Input placeholder="Camera Name" />
        </Form.Item>
        <Form.Item name="code" label="Camera code" rules={rules.code}>
          <Input placeholder="Camera code" />
        </Form.Item>
        <Form.Item name="url" label="AR URL" rules={rules.code}>
          <Input placeholder="AR URL" />
        </Form.Item>
      </Card>
    </Col>
  </Row>
);

export default GeneralField;
