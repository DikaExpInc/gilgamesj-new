import {
  SIGNIN,
  AUTHENTICATED,
  SIGNOUT,
  SIGNOUT_SUCCESS,
  SHOW_AUTH_MESSAGE,
  HIDE_AUTH_MESSAGE,
  SHOW_LOADING,
} from '../constants/Auth'

export const signIn = (user) => {
  return {
    type: SIGNIN,
    payload: user,
  }
}

export const authenticated = (token) => {
  return {
    type: AUTHENTICATED,
    token,
  }
}

export const signOut = () => {
  return {
    type: SIGNOUT,
  }
}

export const signOutSuccess = () => {
  return {
    type: SIGNOUT_SUCCESS,
  }
}

export const showAuthMessage = (message) => {
  return {
    type: SHOW_AUTH_MESSAGE,
    message,
  }
}

export const hideAuthMessage = () => {
  return {
    type: HIDE_AUTH_MESSAGE,
  }
}

export const showLoading = () => {
  return {
    type: SHOW_LOADING,
  }
}
