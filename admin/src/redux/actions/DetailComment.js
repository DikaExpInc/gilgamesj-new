import {
  CREATE_DETAIL_COMMENT,
  DELETE_DETAIL_COMMENT,
  GET_ALL_DETAIL_COMMENT,
  GET_DETAIL_COMMENT,
  UPDATE_DETAIL_COMMENT,
} from "../constants/DetailComment.js";

export const createDetailComment = (data) => {
  return {
    type: CREATE_DETAIL_COMMENT,
    payload: data,
  };
};

export const deleteDetailComment = (id) => {
  return {
    type: DELETE_DETAIL_COMMENT,
    payload: { id },
  };
};

export const getAllDetailComment = (data) => {
  return {
    type: GET_ALL_DETAIL_COMMENT,
    payload: data,
  };
};

export const getDetailComment = (data) => {
  return {
    type: GET_DETAIL_COMMENT,
    payload: data,
  };
};

export const updateDetailComment = (data) => {
  return {
    type: UPDATE_DETAIL_COMMENT,
    payload: data,
  };
};
