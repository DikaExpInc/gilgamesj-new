import {
  CREATE_TASK,
  DELETE_TASK,
  GET_ALL_TASK,
  GET_TASK,
  UPDATE_TASK,
} from "../constants/Task";

const initialState = { data: [] };

function task(task = initialState, action) {
  const { type, payload } = action;
  switch (type) {
    case CREATE_TASK:
      return [task, payload];
    case GET_ALL_TASK:
      return payload;
    case GET_TASK:
      return payload;
    case UPDATE_TASK:
      const dataa = task.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          };
        } else {
          return data;
        }
      });
      return { ...task, data: dataa };
    case DELETE_TASK:
      const data = task.data.filter((data) => data.id !== payload.id.data.id);
      return { ...task, data };

    default:
      return task;
  }
}
export default task;
