import {
  CREATE_DETAIL_COMMENT,
  DELETE_DETAIL_COMMENT,
  GET_ALL_DETAIL_COMMENT,
  GET_DETAIL_COMMENT,
  UPDATE_DETAIL_COMMENT,
} from '../constants/DetailComment'

const initialState = { data: [] }

function detail_comments(detail_comments = initialState, action) {
  const { type, payload } = action
  switch (type) {
    case CREATE_DETAIL_COMMENT:
      return { ...detail_comments, data: [...detail_comments.data, payload] }
    case GET_ALL_DETAIL_COMMENT:
      return { data: payload }
    case GET_DETAIL_COMMENT:
      return payload
    case UPDATE_DETAIL_COMMENT:
      const updatedData = detail_comments.data.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          }
        } else {
          return data
        }
      })
      return { ...detail_comments, data: updatedData }
    case DELETE_DETAIL_COMMENT:
      const filteredData = detail_comments.data.filter(
        (data) => data.id !== payload.id
      )
      return { ...detail_comments, data: filteredData }

    default:
      return detail_comments
  }
}
export default detail_comments
