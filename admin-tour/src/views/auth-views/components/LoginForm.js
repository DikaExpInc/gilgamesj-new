import React, { useEffect } from 'react'
import { connect } from 'react-redux'
import { Button, Form, Input, Alert } from 'antd'
import { MailOutlined, LockOutlined } from '@ant-design/icons'
import PropTypes from 'prop-types'
import {
  signIn,
  showLoading,
  showAuthMessage,
  hideAuthMessage,
} from 'redux/actions/Auth'
import { useHistory } from 'react-router-dom'
import { motion } from 'framer-motion'
import { colorPrimary } from 'configs/AppConfig'

export const LoginForm = (props) => {
  let history = useHistory()

  const {
    showForgetPassword,
    hideAuthMessage,
    showLoading,
    extra,
    signIn,
    token,
    loading,
    redirect,
    showMessage,
    message,
    allowRedirect,
  } = props

  const initialCredential = {
    email: '',
    password: '',
  }

  const onLogin = (values) => {
    showLoading()
    signIn(values)
  }

  useEffect(() => {
    if (token !== null && allowRedirect) {
      history.push(redirect)
    }
    if (showMessage) {
      setTimeout(() => {
        hideAuthMessage()
      }, 3000)
    }
  })

  return (
    <>
      <motion.div
        initial={{ opacity: 0, marginBottom: 0 }}
        animate={{
          opacity: showMessage ? 1 : 0,
          marginBottom: showMessage ? 20 : 0,
        }}
      >
        <Alert type="error" showIcon message={message}></Alert>
      </motion.div>
      <Form
        layout="vertical"
        name="login-form"
        initialValues={initialCredential}
        onFinish={onLogin}
      >
        <Form.Item
          name="email"
          label="Email"
          tooltip="fill your email"
          rules={[
            {
              required: true,
              message: 'Please fill email',
            },
            {
              type: 'email',
              message: 'Please fill email as email format!',
            },
          ]}
        >
          <Input prefix={<MailOutlined className="text-primary" />} />
        </Form.Item>
        <Form.Item
          name="password"
          tooltip="Please fill password"
          label={
            <div
              className={`${
                showForgetPassword
                  ? 'd-flex justify-content-between w-100 align-items-center'
                  : ''
              }`}
            >
              <span>Password</span>
            </div>
          }
          rules={[
            {
              required: true,
              message: 'Please fill your password',
            },
          ]}
        >
          <Input.Password prefix={<LockOutlined className="text-primary" />} />
        </Form.Item>
        <Form.Item>
          <Button
            type="primary"
            htmlType="submit"
            block
            loading={loading}
            style={{
              backgroundColor: colorPrimary,
              border: 'none',
              fontWeight: 700,
            }}
          >
            Log In
          </Button>
        </Form.Item>

        {extra}
      </Form>
    </>
  )
}

LoginForm.propTypes = {
  otherSignIn: PropTypes.bool,
  showForgetPassword: PropTypes.bool,
  extra: PropTypes.oneOfType([PropTypes.string, PropTypes.element]),
}

LoginForm.defaultProps = {
  otherSignIn: true,
  showForgetPassword: false,
}

const mapStateToProps = ({ auth }) => {
  const { loading, message, showMessage, token, redirect } = auth
  return { loading, message, showMessage, token, redirect }
}

const mapDispatchToProps = {
  signIn,
  showAuthMessage,
  showLoading,
  hideAuthMessage,
}

export default connect(mapStateToProps, mapDispatchToProps)(LoginForm)
