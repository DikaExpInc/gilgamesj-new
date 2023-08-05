import {
  CREATE_STAGE,
  DELETE_STAGE,
  GET_ALL_STAGE,
  GET_STAGE,
  UPDATE_STAGE,
} from "../constants/Stage.js";

export const createStage = (data) => {
  return {
    type: CREATE_STAGE,
    payload: data,
  };
};

export const deleteStage = (id) => {
  return {
    type: DELETE_STAGE,
    payload: { id },
  };
};

export const getAllStage = (data) => {
  return {
    type: GET_ALL_STAGE,
    payload: data,
  };
};

export const getStage = (data) => {
  return {
    type: GET_STAGE,
    payload: data,
  };
};

export const updateStage = (data) => {
  return {
    type: UPDATE_STAGE,
    payload: data,
  };
};
