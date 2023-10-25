import {
  CREATE_LIGHT,
  DELETE_LIGHT,
  GET_ALL_LIGHT,
  GET_LIGHT,
  UPDATE_LIGHT,
} from '../constants/Light.js'

export const createLight = (data) => {
  return {
    type: CREATE_LIGHT,
    payload: data,
  }
}

export const deleteLight = (id) => {
  return {
    type: DELETE_LIGHT,
    payload: { id },
  }
}

export const getAllLight = (data) => {
  return {
    type: GET_ALL_LIGHT,
    payload: data,
  }
}

export const getLight = (data) => {
  return {
    type: GET_LIGHT,
    payload: data,
  }
}

export const updateLight = (data) => {
  return {
    type: UPDATE_LIGHT,
    payload: data,
  }
}
