import {
  CREATE_DETAIL_CHAT,
  DELETE_DETAIL_CHAT,
  GET_ALL_DETAIL_CHAT,
  GET_DETAIL_CHAT,
  UPDATE_DETAIL_CHAT,
} from "../constants/DetailChat";

const initialState = { data: [] };

function detailChat(detailChat = initialState, action) {
  const { type, payload } = action;
  switch (type) {
    case CREATE_DETAIL_CHAT:
      return [detailChat, payload];
    case GET_ALL_DETAIL_CHAT:
      return payload;
    case GET_DETAIL_CHAT:
      return payload;
    case UPDATE_DETAIL_CHAT:
      const dataa = detailChat.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          };
        } else {
          return data;
        }
      });
      return { ...detailChat, data: dataa };
    case DELETE_DETAIL_CHAT:
      const data = detailChat.data.filter(
        (data) => data.id !== payload.id.data.id
      );
      return { ...detailChat, data };

    default:
      return detailChat;
  }
}
export default detailChat;
