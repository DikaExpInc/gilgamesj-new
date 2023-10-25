import {
  CREATE_NEWS,
  DELETE_NEWS,
  GET_ALL_NEWS,
  GET_NEWS,
  UPDATE_NEWS,
} from "../constants/News.js";

export const createNews = (data) => {
  return {
    type: CREATE_NEWS,
    payload: data,
  };
};

export const deleteNews = (id) => {
  return {
    type: DELETE_NEWS,
    payload: { id },
  };
};

export const getAllNews = (data) => {
  return {
    type: GET_ALL_NEWS,
    payload: data,
  };
};

export const getNews = (data) => {
  return {
    type: GET_NEWS,
    payload: data,
  };
};

export const updateNews = (data) => {
  return {
    type: UPDATE_NEWS,
    payload: data,
  };
};
