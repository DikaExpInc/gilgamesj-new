import {
  CREATE_SOCIAL_MEDIA,
  DELETE_SOCIAL_MEDIA,
  GET_ALL_SOCIAL_MEDIA,
  GET_SOCIAL_MEDIA,
  UPDATE_SOCIAL_MEDIA,
} from '../constants/SocialMedia.js'

export const createSocialMedia = (data) => {
  return {
    type: CREATE_SOCIAL_MEDIA,
    payload: data,
  }
}

export const deleteSocialMedia = (id) => {
  return {
    type: DELETE_SOCIAL_MEDIA,
    payload: { id },
  }
}

export const getAllSocialMedia = (data) => {
  return {
    type: GET_ALL_SOCIAL_MEDIA,
    payload: data,
  }
}

export const getSocialMedia = (data) => {
  return {
    type: GET_SOCIAL_MEDIA,
    payload: data,
  }
}

export const updateSocialMedia = (data) => {
  return {
    type: UPDATE_SOCIAL_MEDIA,
    payload: data,
  }
}
