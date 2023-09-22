import {
  CREATE_USER,
  DELETE_PLAYER,
  DELETE_USER,
  GET_ALL_USER,
  GET_USER,
  UPDATE_USER,
} from '../constants/User.js'

export const createUser = (data) => {
  return {
    type: CREATE_USER,
    payload: data,
  }
}

export const deleteUser = (id) => {
  return {
    type: DELETE_USER,
    payload: { id },
  }
}

export const deletePlayer = (id) => {
  return {
    type: DELETE_PLAYER,
    payload: { id },
  }
}

export const getAllUser = (data) => {
  return {
    type: GET_ALL_USER,
    payload: data,
  }
}

export const getUser = (data) => {
  return {
    type: GET_USER,
    payload: data,
  }
}

export const updateUser = (data) => {
  return {
    type: UPDATE_USER,
    payload: data,
  }
}
