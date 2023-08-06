import {
  CREATE_CAMERA,
  DELETE_CAMERA,
  GET_ALL_CAMERA,
  GET_CAMERA,
  UPDATE_CAMERA,
} from '../constants/Camera'

const initialState = { data: [] }

function camera(camera = initialState, action) {
  const { type, payload } = action
  switch (type) {
    case CREATE_CAMERA:
      return { ...camera, data: [...camera.data, payload] }
    case GET_ALL_CAMERA:
      return { data: payload }
    case GET_CAMERA:
      return payload
    case UPDATE_CAMERA:
      const updatedData = camera.data.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          }
        } else {
          return data
        }
      })
      return { ...camera, data: updatedData }
    case DELETE_CAMERA:
      const filteredData = camera.data.filter((data) => data.id !== payload.id)
      return { ...camera, data: filteredData }

    default:
      return camera
  }
}
export default camera
