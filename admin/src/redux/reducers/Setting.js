import {
  CREATE_SETTING,
  DELETE_SETTING,
  GET_ALL_SETTING,
  GET_SETTING,
  UPDATE_SETTING,
} from "../constants/Setting";

const initialState = { data: [] };

function setting(setting = initialState, action) {
  const { type, payload } = action;
  switch (type) {
    case CREATE_SETTING:
      return [setting, payload];
    case GET_ALL_SETTING:
      return payload;
    case GET_SETTING:
      return {
        ...setting,
        attributes: payload.attributes,
      };
    case DELETE_SETTING:
      const data = setting.data.filter(
        (data) => data.id !== payload.id.data.id
      );
      return { ...setting, data };

    default:
      return setting;
  }
}
export default setting;
