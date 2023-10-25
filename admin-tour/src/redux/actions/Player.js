import {
  CREATE_PLAYER,
  DELETE_PLAYER,
  GET_ALL_PLAYER,
  GET_PLAYER,
  UPDATE_PLAYER,
} from '../constants/Player.js'

export const createPlayer = (data) => {
  return {
    type: CREATE_PLAYER,
    payload: data,
  }
}

export const deletePlayer = (id) => {
  return {
    type: DELETE_PLAYER,
    payload: { id },
  }
}

export const getAllPlayer = (data) => {
  return {
    type: GET_ALL_PLAYER,
    payload: data,
  }
}

export const getPlayer = (data) => {
  return {
    type: GET_PLAYER,
    payload: data,
  }
}

export const updatePlayer = (data) => {
  return {
    type: UPDATE_PLAYER,
    payload: data,
  }
}
