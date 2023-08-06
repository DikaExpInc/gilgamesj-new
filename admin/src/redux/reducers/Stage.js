import {
  CREATE_STAGE,
  DELETE_STAGE,
  GET_ALL_STAGE,
  GET_STAGE,
  UPDATE_STAGE,
} from '../constants/Stage'

const initialState = { data: [] }

function stage(stage = initialState, action) {
  const { type, payload } = action
  switch (type) {
    case CREATE_STAGE:
      return { ...stage, data: [...stage.data, payload] }
    case GET_ALL_STAGE:
      return { data: payload }
    case GET_STAGE:
      return payload
    case UPDATE_STAGE:
      const updatedData = stage.data.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          }
        } else {
          return data
        }
      })
      return { ...stage, data: updatedData }
    case DELETE_STAGE:
      const filteredData = stage.data.filter((data) => data.id !== payload.id)
      return { ...stage, data: filteredData }
    default:
      return stage
  }
}
export default stage
