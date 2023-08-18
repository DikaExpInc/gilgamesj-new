import {
  CREATE_CHAT_DETAIL,
  DELETE_CHAT_DETAIL,
  GET_ALL_CHAT_DETAIL,
  GET_CHAT_DETAIL,
  UPDATE_CHAT_DETAIL,
} from '../constants/ChatDetail'

const initialState = { data: [] }

function chatDetail(chatDetail = initialState, action) {
  const { type, payload } = action
  switch (type) {
    case CREATE_CHAT_DETAIL:
      return { ...chatDetail, data: [...chatDetail.data, payload] }
    case GET_ALL_CHAT_DETAIL:
      return { data: payload }
    case GET_CHAT_DETAIL:
      return payload
    case UPDATE_CHAT_DETAIL:
      const updatedData = chatDetail.data.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          }
        } else {
          return data
        }
      })
      return { ...chatDetail, data: updatedData }
    case DELETE_CHAT_DETAIL:
      const filteredData = chatDetail.data.filter(
        (data) => data.id !== payload.id
      )
      return { ...chatDetail, data: filteredData }
    default:
      return chatDetail
  }
}
export default chatDetail
