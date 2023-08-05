import {
  CREATE_CHAT,
  DELETE_CHAT,
  GET_ALL_CHAT,
  GET_CHAT,
  UPDATE_CHAT,
} from "../constants/Chat";

const initialState = { data: [] };

function chat(chat = initialState, action) {
  const { type, payload } = action;
  switch (type) {
    case CREATE_CHAT:
      return [chat, payload];
    case GET_ALL_CHAT:
      return payload;
    case GET_CHAT:
      return payload;
    case UPDATE_CHAT:
      const dataa = chat.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          };
        } else {
          return data;
        }
      });
      return { ...chat, data: dataa };
    case DELETE_CHAT:
      const data = chat.data.filter((data) => data.id !== payload.id.data.id);
      return { ...chat, data };

    default:
      return chat;
  }
}
export default chat;
