import {
  CREATE_USER,
  DELETE_PLAYER,
  DELETE_USER,
  GET_ALL_USER,
  GET_USER,
  UPDATE_USER,
} from '../constants/User'

const initialState = { data: [] }

function user(user = initialState, action) {
  const { type, payload } = action
  switch (type) {
    case CREATE_USER:
      return { ...user, data: [...user.data, payload] }
    case GET_ALL_USER:
      return { data: payload }
    case GET_USER:
      return payload
    case UPDATE_USER:
      const updatedData = user.data.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          }
        } else {
          return data
        }
      })
      return { ...user, data: updatedData }
    case DELETE_USER:
      const filteredData = user.data.filter((data) => data.id !== payload.id)
      return { ...user, data: filteredData }
    case DELETE_PLAYER:
      const filteredPlayer = user.data.filter((data) => data.id !== payload.id)
      return { ...user, data: filteredPlayer }

    default:
      return user
  }
}
export default user
