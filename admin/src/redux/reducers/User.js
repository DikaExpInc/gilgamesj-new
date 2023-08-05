import {
  CREATE_USER,
  DELETE_USER,
  GET_ALL_USER,
  GET_USER,
  UPDATE_USER,
} from "../constants/User";

const initialState = { data: [] };

function user(user = initialState, action) {
  const { type, payload } = action;
  switch (type) {
    case CREATE_USER:
      return [user, payload];
    case GET_ALL_USER:
      return payload;
    case GET_USER:
      return payload;
    case UPDATE_USER:
      const dataa = user.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          };
        } else {
          return data;
        }
      });
      return { ...user, data: dataa };
    case DELETE_USER:
      const data = user.data.filter((data) => data.id !== payload.id.data.id);
      return { ...user, data };

    default:
      return user;
  }
}
export default user;
