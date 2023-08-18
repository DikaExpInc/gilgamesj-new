import {
  CREATE_SOCIAL_MEDIA_COMMENT,
  DELETE_SOCIAL_MEDIA_COMMENT,
  GET_ALL_SOCIAL_MEDIA_COMMENT,
  GET_SOCIAL_MEDIA_COMMENT,
  UPDATE_SOCIAL_MEDIA_COMMENT,
} from '../constants/SocialMediaComment.js'

export const createSocialMediaComment = (data) => {
  return {
    type: CREATE_SOCIAL_MEDIA_COMMENT,
    payload: data,
  }
}

export const deleteSocialMediaComment = (id) => {
  return {
    type: DELETE_SOCIAL_MEDIA_COMMENT,
    payload: { id },
  }
}

export const getAllSocialMediaComment = (data) => {
  return {
    type: GET_ALL_SOCIAL_MEDIA_COMMENT,
    payload: data,
  }
}

export const getSocialMediaComment = (data) => {
  return {
    type: GET_SOCIAL_MEDIA_COMMENT,
    payload: data,
  }
}

export const updateSocialMediaComment = (data) => {
  return {
    type: UPDATE_SOCIAL_MEDIA_COMMENT,
    payload: data,
  }
}
