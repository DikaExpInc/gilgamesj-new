import {
  CREATE_CHAT,
  DELETE_CHAT,
  GET_ALL_CHAT,
  GET_CHAT,
  UPDATE_CHAT,
} from '../constants/Chat'

const initialState = { data: [] }

function chat(chat = initialState, action) {
  const { type, payload } = action
  switch (type) {
    case CREATE_CHAT:
      return { ...chat, data: [...chat.data, payload] }
    case GET_ALL_CHAT:
      return { data: payload }
    case GET_CHAT:
      return payload
    case UPDATE_CHAT:
      const updatedData = chat.data.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          }
        } else {
          return data
        }
      })
      return { ...chat, data: updatedData }
    case DELETE_CHAT:
      const filteredData = chat.data.filter((data) => data.id !== payload.id)
      return { ...chat, data: filteredData }

    default:
      return chat
  }
}
export default chat
