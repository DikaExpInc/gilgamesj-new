import {
  CREATE_GALLERY_PHOTO,
  DELETE_GALLERY_PHOTO,
  GET_ALL_GALLERY_PHOTO,
  GET_GALLERY_PHOTO,
  UPDATE_GALLERY_PHOTO,
} from "../constants/GalleryPhoto";

const initialState = { data: [] };

function gallery_photo(gallery_photo = initialState, action) {
  const { type, payload } = action;
  switch (type) {
    case CREATE_GALLERY_PHOTO:
      return [gallery_photo, payload];
    case GET_ALL_GALLERY_PHOTO:
      return payload;
    case GET_GALLERY_PHOTO:
      return payload;
    case UPDATE_GALLERY_PHOTO:
      console.log(gallery_photo);
      const dataa = gallery_photo.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          };
        } else {
          return data;
        }
      });
      return { ...gallery_photo, data: dataa };
    case DELETE_GALLERY_PHOTO:
      const data = gallery_photo.data.filter(
        (data) => data.id !== payload.id.data.id
      );
      return { ...gallery_photo, data };

    default:
      return gallery_photo;
  }
}
export default gallery_photo;
