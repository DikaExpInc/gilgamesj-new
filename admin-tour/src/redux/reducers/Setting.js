import {
  CREATE_SETTING,
  DELETE_SETTING,
  GET_ALL_SETTING,
  GET_SETTING,
  UPDATE_SETTING,
} from '../constants/Setting'

const initialState = { data: [] }

function setting(setting = initialState, action) {
  const { type, payload } = action
  switch (type) {
    case CREATE_SETTING:
      return { ...setting, data: [...setting.data, payload] }
    case GET_ALL_SETTING:
      return { data: payload }
    case GET_SETTING:
      return payload
    case UPDATE_SETTING:
      const updatedData = setting.data.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          }
        } else {
          return data
        }
      })
      return { ...setting, data: updatedData }
    case DELETE_SETTING:
      const filteredData = setting.data.filter((data) => data.id !== payload.id)
      return { ...setting, data: filteredData }
    default:
      return setting
  }
}
export default setting
