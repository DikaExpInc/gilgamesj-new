import {
  CREATE_LIGHT,
  DELETE_LIGHT,
  GET_ALL_LIGHT,
  GET_LIGHT,
  UPDATE_LIGHT,
} from '../constants/Light'

const initialState = { data: [] }

function light(light = initialState, action) {
  const { type, payload } = action
  switch (type) {
    case CREATE_LIGHT:
      return { ...light, data: [...light.data, payload] }
    case GET_ALL_LIGHT:
      return { data: payload }
    case GET_LIGHT:
      return payload
    case UPDATE_LIGHT:
      const updatedData = light.data.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          }
        } else {
          return data
        }
      })
      return { ...light, data: updatedData }
    case DELETE_LIGHT:
      const filteredData = light.data.filter((data) => data.id !== payload.id)
      return { ...light, data: filteredData }

    default:
      return light
  }
}
export default light
