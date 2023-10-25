import {
  CREATE_PRE_GAME,
  DELETE_PRE_GAME,
  GET_ALL_PRE_GAME,
  GET_PRE_GAME,
  UPDATE_PRE_GAME,
} from "../constants/PreGame.js";

export const createPreGame = (data) => {
  return {
    type: CREATE_PRE_GAME,
    payload: data,
  };
};

export const deletePreGame = (id) => {
  return {
    type: DELETE_PRE_GAME,
    payload: { id },
  };
};

export const getAllPreGame = (data) => {
  return {
    type: GET_ALL_PRE_GAME,
    payload: data,
  };
};

export const getPreGame = (data) => {
  return {
    type: GET_PRE_GAME,
    payload: data,
  };
};

export const updatePreGame = (data) => {
  return {
    type: UPDATE_PRE_GAME,
    payload: data,
  };
};
