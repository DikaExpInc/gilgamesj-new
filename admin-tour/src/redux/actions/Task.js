import {
  CREATE_TASK,
  DELETE_TASK,
  GET_ALL_TASK,
  GET_TASK,
  UPDATE_TASK,
} from "../constants/Task.js";

export const createTask = (data) => {
  return {
    type: CREATE_TASK,
    payload: data,
  };
};

export const deleteTask = (id) => {
  return {
    type: DELETE_TASK,
    payload: { id },
  };
};

export const getAllTask = (data) => {
  return {
    type: GET_ALL_TASK,
    payload: data,
  };
};

export const getTask = (data) => {
  return {
    type: GET_TASK,
    payload: data,
  };
};

export const updateTask = (data) => {
  return {
    type: UPDATE_TASK,
    payload: data,
  };
};
