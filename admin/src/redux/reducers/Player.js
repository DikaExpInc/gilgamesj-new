/* eslint-disable no-duplicate-case */
import {
  CREATE_PLAYER,
  DELETE_PLAYER,
  GET_ALL_PLAYER,
  GET_PLAYER,
  UPDATE_PLAYER,
} from '../constants/Player'

const initialState = { data: [] }

function player(player = initialState, action) {
  const { type, payload } = action
  switch (type) {
    case CREATE_PLAYER:
      return { ...player, data: [...player.data, payload] }
    case GET_ALL_PLAYER:
      return { data: payload }
    case GET_PLAYER:
      return payload
    case UPDATE_PLAYER:
      const updatedData = player.data.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          }
        } else {
          return data
        }
      })
      return { ...player, data: updatedData }
    case DELETE_PLAYER:
      const filteredData = player.data.filter((data) => data.id !== payload.id)
      return { ...player, data: filteredData }
    case DELETE_PLAYER:
      const filteredPlayer = player.data.filter((data) => data.id !== payload.id)
      return { ...player, data: filteredPlayer }

    default:
      return player
  }
}
export default player
