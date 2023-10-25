import {
  CREATE_GALLERY_VIDEO,
  DELETE_GALLERY_VIDEO,
  GET_ALL_GALLERY_VIDEO,
  GET_GALLERY_VIDEO,
  UPDATE_GALLERY_VIDEO,
} from '../constants/GalleryVideo'

const initialState = { data: [] }

function gallery_video(gallery_video = initialState, action) {
  const { type, payload } = action
  switch (type) {
    case CREATE_GALLERY_VIDEO:
      return { ...gallery_video, data: [...gallery_video.data, payload] }
    case GET_ALL_GALLERY_VIDEO:
      return { data: payload }
    case GET_GALLERY_VIDEO:
      return payload
    case UPDATE_GALLERY_VIDEO:
      const updatedData = gallery_video.data.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          }
        } else {
          return data
        }
      })
      return { ...gallery_video, data: updatedData }
    case DELETE_GALLERY_VIDEO:
      const filteredData = gallery_video.data.filter(
        (data) => data.id !== payload.id
      )
      return { ...gallery_video, data: filteredData }

    default:
      return gallery_video
  }
}
export default gallery_video
