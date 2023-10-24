import {
  CREATE_THEATER,
  DELETE_THEATER,
  GET_ALL_THEATER,
  GET_THEATER,
  UPDATE_THEATER,
} from '../constants/Theater'

const initialState = { data: [] }

function theater(theater = initialState, action) {
  const { type, payload } = action
  switch (type) {
    case CREATE_THEATER:
      return { ...theater, data: [...theater.data, payload] }
    case GET_ALL_THEATER:
      return { data: payload }
    case GET_THEATER:
      return payload
    case UPDATE_THEATER:
      const updatedData = theater.data.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          }
        } else {
          return data
        }
      })
      return { ...theater, data: updatedData }
    case DELETE_THEATER:
      const filteredData = theater.data.filter((data) => data.id !== payload.id)
      return { ...theater, data: filteredData }

    default:
      return theater
  }
}
export default theater
