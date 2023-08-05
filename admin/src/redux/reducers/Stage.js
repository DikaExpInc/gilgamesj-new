import {
  CREATE_STAGE,
  DELETE_STAGE,
  GET_ALL_STAGE,
  GET_STAGE,
  UPDATE_STAGE,
} from "../constants/Stage";

const initialState = { data: [] };

function stage(stage = initialState, action) {
  const { type, payload } = action;
  switch (type) {
    case CREATE_STAGE:
      return [stage, payload];
    case GET_ALL_STAGE:
      return payload;
    case GET_STAGE:
      return payload;
    case UPDATE_STAGE:
      const dataa = stage.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          };
        } else {
          return data;
        }
      });
      return { ...stage, data: dataa };
    case DELETE_STAGE:
      const data = stage.data.filter((data) => data.id !== payload.id.data.id);
      return { ...stage, data };

    default:
      return stage;
  }
}
export default stage;
