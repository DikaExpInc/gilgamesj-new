import {
  CREATE_DETAIL_CHAT,
  DELETE_DETAIL_CHAT,
  GET_ALL_DETAIL_CHAT,
  GET_DETAIL_CHAT,
  UPDATE_DETAIL_CHAT,
} from "../constants/DetailChat.js";

export const createDetailChat = (data) => {
  return {
    type: CREATE_DETAIL_CHAT,
    payload: data,
  };
};

export const deleteDetailChat = (id) => {
  return {
    type: DELETE_DETAIL_CHAT,
    payload: { id },
  };
};

export const getAllDetailChat = (data) => {
  return {
    type: GET_ALL_DETAIL_CHAT,
    payload: data,
  };
};

export const getDetailChat = (data) => {
  return {
    type: GET_DETAIL_CHAT,
    payload: data,
  };
};

export const updateDetailChat = (data) => {
  return {
    type: UPDATE_DETAIL_CHAT,
    payload: data,
  };
};
