import {
  CREATE_MAPS,
  DELETE_MAPS,
  GET_ALL_MAPS,
  GET_MAPS,
  UPDATE_MAPS,
} from "../constants/Maps.js";

export const createMaps = (data) => {
  return {
    type: CREATE_MAPS,
    payload: data,
  };
};

export const deleteMaps = (id) => {
  return {
    type: DELETE_MAPS,
    payload: { id },
  };
};

export const getAllMaps = (data) => {
  return {
    type: GET_ALL_MAPS,
    payload: data,
  };
};

export const getMaps = (data) => {
  return {
    type: GET_MAPS,
    payload: data,
  };
};

export const updateMaps = (data) => {
  return {
    type: UPDATE_MAPS,
    payload: data,
  };
};
