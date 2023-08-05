import {
  CREATE_CAMERA,
  DELETE_CAMERA,
  GET_ALL_CAMERA,
  GET_CAMERA,
  UPDATE_CAMERA,
} from "../constants/Camera.js";

export const createCamera = (data) => {
  return {
    type: CREATE_CAMERA,
    payload: data,
  };
};

export const deleteCamera = (id) => {
  return {
    type: DELETE_CAMERA,
    payload: { id },
  };
};

export const getAllCamera = (data) => {
  return {
    type: GET_ALL_CAMERA,
    payload: data,
  };
};

export const getCamera = (data) => {
  return {
    type: GET_CAMERA,
    payload: data,
  };
};

export const updateCamera = (data) => {
  return {
    type: UPDATE_CAMERA,
    payload: data,
  };
};
