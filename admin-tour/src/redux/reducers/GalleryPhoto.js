import {
  CREATE_GALLERY_PHOTO,
  DELETE_GALLERY_PHOTO,
  GET_ALL_GALLERY_PHOTO,
  GET_GALLERY_PHOTO,
  UPDATE_GALLERY_PHOTO,
} from '../constants/GalleryPhoto'

const initialState = { data: [] }

function gallery_photo(gallery_photo = initialState, action) {
  const { type, payload } = action
  switch (type) {
    case CREATE_GALLERY_PHOTO:
      return { ...gallery_photo, data: [...gallery_photo.data, payload] }
    case GET_ALL_GALLERY_PHOTO:
      return { data: payload }
    case GET_GALLERY_PHOTO:
      return payload
    case UPDATE_GALLERY_PHOTO:
      const updatedData = gallery_photo.data.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          }
        } else {
          return data
        }
      })
      return { ...gallery_photo, data: updatedData }
    case DELETE_GALLERY_PHOTO:
      const filteredData = gallery_photo.data.filter(
        (data) => data.id !== payload.id
      )
      return { ...gallery_photo, data: filteredData }
    default:
      return gallery_photo
  }
}
export default gallery_photo
