import {
  CREATE_DETAIL_COMMENT,
  DELETE_DETAIL_COMMENT,
  GET_ALL_DETAIL_COMMENT,
  GET_DETAIL_COMMENT,
  UPDATE_DETAIL_COMMENT,
} from "../constants/DetailComment";

const initialState = { data: [] };

function detail_comments(detail_comments = initialState, action) {
  const { type, payload } = action;
  switch (type) {
    case CREATE_DETAIL_COMMENT:
      return [detail_comments, payload];
    case GET_ALL_DETAIL_COMMENT:
      return payload;
    case GET_DETAIL_COMMENT:
      return payload;
    case UPDATE_DETAIL_COMMENT:
      const dataa = detail_comments.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          };
        } else {
          return data;
        }
      });
      return { ...detail_comments, data: dataa };
    case DELETE_DETAIL_COMMENT:
      const data = detail_comments.data.filter(
        (data) => data.id !== payload.id.data.id
      );
      return { ...detail_comments, data };

    default:
      return detail_comments;
  }
}
export default detail_comments;
