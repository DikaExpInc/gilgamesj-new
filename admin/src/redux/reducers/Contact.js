import {
  CREATE_CONTACT,
  DELETE_CONTACT,
  GET_ALL_CONTACT,
  GET_CONTACT,
  UPDATE_CONTACT,
} from '../constants/Contact'

const initialState = { data: [] }

function contact(contact = initialState, action) {
  const { type, payload } = action
  switch (type) {
    case CREATE_CONTACT:
      return { ...contact, data: [...contact.data, payload] }
    case GET_ALL_CONTACT:
      return { data: payload }
    case GET_CONTACT:
      return payload
    case UPDATE_CONTACT:
      const updatedData = contact.data.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          }
        } else {
          return data
        }
      })
      return { ...contact, data: updatedData }
    case DELETE_CONTACT:
      const filteredData = contact.data.filter((data) => data.id !== payload.id)
      return { ...contact, data: filteredData }

    default:
      return contact
  }
}
export default contact
