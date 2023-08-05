import {
  CREATE_CHAT,
  DELETE_CHAT,
  GET_ALL_CHAT,
  GET_CHAT,
  UPDATE_CHAT,
} from "../constants/Chat.js";

export const createChat = (data) => {
  return {
    type: CREATE_CHAT,
    payload: data,
  };
};

export const deleteChat = (id) => {
  return {
    type: DELETE_CHAT,
    payload: { id },
  };
};

export const getAllChat = (data) => {
  return {
    type: GET_ALL_CHAT,
    payload: data,
  };
};

export const getChat = (data) => {
  return {
    type: GET_CHAT,
    payload: data,
  };
};

export const updateChat = (data) => {
  return {
    type: UPDATE_CHAT,
    payload: data,
  };
};
