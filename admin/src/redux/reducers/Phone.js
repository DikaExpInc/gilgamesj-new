import {
  CREATE_PHONE,
  DELETE_PHONE,
  GET_ALL_PHONE,
  GET_PHONE,
  UPDATE_PHONE,
} from '../constants/Phone'

const initialState = { data: [] }

function phone(phone = initialState, action) {
  const { type, payload } = action
  switch (type) {
    case CREATE_PHONE:
      return { ...phone, data: [...phone.data, payload] }
    case GET_ALL_PHONE:
      return { data: payload }
    case GET_PHONE:
      return payload
    case UPDATE_PHONE:
      const updatedData = phone.data.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          }
        } else {
          return data
        }
      })
      return { ...phone, data: updatedData }
    case DELETE_PHONE:
      const filteredData = phone.data.filter((data) => data.id !== payload.id)
      return { ...phone, data: filteredData }
    default:
      return phone
  }
}
export default phone
