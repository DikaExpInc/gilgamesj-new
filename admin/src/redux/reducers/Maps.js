import {
  CREATE_MAPS,
  DELETE_MAPS,
  GET_ALL_MAPS,
  GET_MAPS,
  UPDATE_MAPS,
} from "../constants/Maps";

const initialState = { data: [] };

function maps(maps = initialState, action) {
  const { type, payload } = action;
  switch (type) {
    case CREATE_MAPS:
      return [maps, payload];
    case GET_ALL_MAPS:
      return payload;
    case GET_MAPS:
      return payload;
    case UPDATE_MAPS:
      const dataa = maps.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          };
        } else {
          return data;
        }
      });
      return { ...maps, data: dataa };
    case DELETE_MAPS:
      const data = maps.data.filter((data) => data.id !== payload.id.data.id);
      return { ...maps, data };

    default:
      return maps;
  }
}
export default maps;
