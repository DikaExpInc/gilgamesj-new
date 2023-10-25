import {
  CREATE_PHONE,
  DELETE_PHONE,
  GET_ALL_PHONE,
  GET_PHONE,
  UPDATE_PHONE,
} from "../constants/Phone.js";

export const createPhone = (data) => {
  return {
    type: CREATE_PHONE,
    payload: data,
  };
};

export const deletePhone = (id) => {
  return {
    type: DELETE_PHONE,
    payload: { id },
  };
};

export const getAllPhone = (data) => {
  return {
    type: GET_ALL_PHONE,
    payload: data,
  };
};

export const getPhone = (data) => {
  return {
    type: GET_PHONE,
    payload: data,
  };
};

export const updatePhone = (data) => {
  return {
    type: UPDATE_PHONE,
    payload: data,
  };
};
