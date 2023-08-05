import {
  CREATE_NEWS,
  DELETE_NEWS,
  GET_ALL_NEWS,
  GET_NEWS,
  UPDATE_NEWS,
} from "../constants/News";

const initialState = { data: [] };

function news(news = initialState, action) {
  const { type, payload } = action;
  switch (type) {
    case CREATE_NEWS:
      return [news, payload];
    case GET_ALL_NEWS:
      return payload;
    case GET_NEWS:
      return payload;
    case UPDATE_NEWS:
      const dataa = news.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          };
        } else {
          return data;
        }
      });
      return { ...news, data: dataa };
    case DELETE_NEWS:
      const data = news.data.filter((data) => data.id !== payload.id.data.id);
      return { ...news, data };

    default:
      return news;
  }
}
export default news;
