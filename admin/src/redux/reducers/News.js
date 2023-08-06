import {
  CREATE_NEWS,
  DELETE_NEWS,
  GET_ALL_NEWS,
  GET_NEWS,
  UPDATE_NEWS,
} from '../constants/News'

const initialState = { data: [] }

function news(news = initialState, action) {
  const { type, payload } = action
  switch (type) {
    case CREATE_NEWS:
      return { ...news, data: [...news.data, payload] }
    case GET_ALL_NEWS:
      return { data: payload }
    case GET_NEWS:
      return payload
    case UPDATE_NEWS:
      const updatedData = news.data.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          }
        } else {
          return data
        }
      })
      return { ...news, data: updatedData }
    case DELETE_NEWS:
      const filteredData = news.data.filter((data) => data.id !== payload.id)
      return { ...news, data: filteredData }
    default:
      return news
  }
}
export default news
