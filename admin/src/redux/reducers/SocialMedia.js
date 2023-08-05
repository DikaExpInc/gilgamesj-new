import {
  CREATE_SOCIAL_MEDIA,
  DELETE_SOCIAL_MEDIA,
  GET_ALL_SOCIAL_MEDIA,
  GET_SOCIAL_MEDIA,
  UPDATE_SOCIAL_MEDIA,
} from "../constants/SocialMedia";

const initialState = { data: [] };

function social_medias(social_medias = initialState, action) {
  const { type, payload } = action;
  switch (type) {
    case CREATE_SOCIAL_MEDIA:
      return [social_medias, payload];
    case GET_ALL_SOCIAL_MEDIA:
      return payload;
    case GET_SOCIAL_MEDIA:
      return payload;
    case UPDATE_SOCIAL_MEDIA:
      const dataa = social_medias.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          };
        } else {
          return data;
        }
      });
      return { ...social_medias, data: dataa };
    case DELETE_SOCIAL_MEDIA:
      const data = social_medias.data.filter(
        (data) => data.id !== payload.id.data.id
      );
      return { ...social_medias, data };

    default:
      return social_medias;
  }
}
export default social_medias;
