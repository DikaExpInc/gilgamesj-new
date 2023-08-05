import React from "react";
import LoginForm from "../../components/LoginForm";
import { Row, Col } from "antd";
import { useSelector } from "react-redux";
import { colorPrimary } from "configs/AppConfig";

const backgroundURL = "/img/others/img-17.jpg";
const backgroundStyle = {
  backgroundImage: `url(${backgroundURL})`,
  backgroundRepeat: "no-repeat",
  backgroundSize: "cover",
};

const LoginTwo = (props) => {
  const theme = useSelector((state) => state.theme.currentTheme);

  return (
    <div className={`h-100 ${theme === "light" ? "bg-white" : ""}`}>
      <Row justify="center" className="align-items-stretch h-100">
        <Col xs={0} sm={0} md={0} lg={14}>
          <div
            className="d-flex flex-column justify-content-between h-100 px-4"
            style={backgroundStyle}
          ></div>
        </Col>
        <Col xs={20} sm={20} md={24} lg={10}>
          <div className="container d-flex flex-column justify-content-around h-100">
            <Row justify="center">
              <Col xs={24} sm={24} md={20} lg={18} xl={14}>
                <div className="text-left">
                  <img src="/img/logo-big.png" alt="logo" />
                </div>
              </Col>
            </Row>
            <Row justify="center">
              <Col xs={24} sm={24} md={20} lg={18} xl={14}>
                <h1 style={{ fontWeight: 700, color: colorPrimary }}>Log In</h1>
                <p>Use the admin account</p>
                <div className="mt-4">
                  <LoginForm {...props} />
                </div>
              </Col>
            </Row>
            <Row></Row>
          </div>
        </Col>
      </Row>
    </div>
  );
};

export default LoginTwo;
