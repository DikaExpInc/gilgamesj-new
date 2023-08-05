import {
  CREATE_SETTING,
  DELETE_SETTING,
  GET_ALL_SETTING,
  GET_SETTING,
  UPDATE_SETTING,
} from "../constants/Setting.js";

export const createSetting = (data) => {
  return {
    type: CREATE_SETTING,
    payload: data,
  };
};

export const deleteSetting = (id) => {
  return {
    type: DELETE_SETTING,
    payload: { id },
  };
};

export const getAllSetting = (data) => {
  return {
    type: GET_ALL_SETTING,
    payload: data,
  };
};

export const getSetting = (data) => {
  return {
    type: GET_SETTING,
    payload: data,
  };
};

export const updateSetting = (data) => {
  return {
    type: UPDATE_SETTING,
    payload: data,
  };
};
