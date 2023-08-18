import {
  CREATE_CHAT_DETAIL,
  DELETE_CHAT_DETAIL,
  GET_ALL_CHAT_DETAIL,
  GET_CHAT_DETAIL,
  UPDATE_CHAT_DETAIL,
} from '../constants/ChatDetail.js'

export const createChatDetail = (data) => {
  return {
    type: CREATE_CHAT_DETAIL,
    payload: data,
  }
}

export const deleteChatDetail = (id) => {
  return {
    type: DELETE_CHAT_DETAIL,
    payload: { id },
  }
}

export const getAllChatDetail = (data) => {
  return {
    type: GET_ALL_CHAT_DETAIL,
    payload: data,
  }
}

export const getChatDetail = (data) => {
  return {
    type: GET_CHAT_DETAIL,
    payload: data,
  }
}

export const updateChatDetail = (data) => {
  return {
    type: UPDATE_CHAT_DETAIL,
    payload: data,
  }
}
