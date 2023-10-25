import {
  CREATE_SOCIAL_MEDIA_COMMENT,
  DELETE_SOCIAL_MEDIA_COMMENT,
  GET_ALL_SOCIAL_MEDIA_COMMENT,
  GET_SOCIAL_MEDIA_COMMENT,
  UPDATE_SOCIAL_MEDIA_COMMENT,
} from '../constants/SocialMediaComment'

const initialState = { data: [] }

function social_media_comments(social_media_comments = initialState, action) {
  const { type, payload } = action
  switch (type) {
    case CREATE_SOCIAL_MEDIA_COMMENT:
      return {
        ...social_media_comments,
        data: [...social_media_comments.data, payload],
      }
    case GET_ALL_SOCIAL_MEDIA_COMMENT:
      return { data: payload }
    case GET_SOCIAL_MEDIA_COMMENT:
      return payload
    case UPDATE_SOCIAL_MEDIA_COMMENT:
      const updatedData = social_media_comments.data.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          }
        } else {
          return data
        }
      })
      return { ...social_media_comments, data: updatedData }
    case DELETE_SOCIAL_MEDIA_COMMENT:
      const filteredData = social_media_comments.data.filter(
        (data) => data.id !== payload.id
      )
      return { ...social_media_comments, data: filteredData }
    default:
      return social_media_comments
  }
}
export default social_media_comments
