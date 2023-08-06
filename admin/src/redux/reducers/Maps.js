import {
  CREATE_MAPS,
  DELETE_MAPS,
  GET_ALL_MAPS,
  GET_MAPS,
  UPDATE_MAPS,
} from '../constants/Maps'

const initialState = { data: [] }

function maps(maps = initialState, action) {
  const { type, payload } = action
  switch (type) {
    case CREATE_MAPS:
      return { ...maps, data: [...maps.data, payload] }
    case GET_ALL_MAPS:
      return { data: payload }
    case GET_MAPS:
      return payload
    case UPDATE_MAPS:
      const updatedData = maps.data.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          }
        } else {
          return data
        }
      })
      return { ...maps, data: updatedData }
    case DELETE_MAPS:
      const filteredData = maps.data.filter((data) => data.id !== payload.id)
      return { ...maps, data: filteredData }
    default:
      return maps
  }
}
export default maps
