import {
  CREATE_TASK,
  DELETE_TASK,
  GET_ALL_TASK,
  GET_TASK,
  UPDATE_TASK,
} from '../constants/Task'

const initialState = { data: [] }

function task(task = initialState, action) {
  const { type, payload } = action
  switch (type) {
    case CREATE_TASK:
      return { ...task, data: [...task.data, payload] }
    case GET_ALL_TASK:
      return { data: payload }
    case GET_TASK:
      return payload
    case UPDATE_TASK:
      const updatedData = task.data.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          }
        } else {
          return data
        }
      })
      return { ...task, data: updatedData }
    case DELETE_TASK:
      const filteredData = task.data.filter((data) => data.id !== payload.id)
      return { ...task, data: filteredData }

    default:
      return task
  }
}
export default task
