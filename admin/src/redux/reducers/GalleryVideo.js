import {
  CREATE_GALLERY_VIDEO,
  DELETE_GALLERY_VIDEO,
  GET_ALL_GALLERY_VIDEO,
  GET_GALLERY_VIDEO,
  UPDATE_GALLERY_VIDEO,
} from "../constants/GalleryVideo";

const initialState = { data: [] };

function gallery_video(gallery_video = initialState, action) {
  const { type, payload } = action;
  switch (type) {
    case CREATE_GALLERY_VIDEO:
      return [gallery_video, payload];
    case GET_ALL_GALLERY_VIDEO:
      return payload;
    case GET_GALLERY_VIDEO:
      return payload;
    case UPDATE_GALLERY_VIDEO:
      const dataa = gallery_video.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          };
        } else {
          return data;
        }
      });
      return { ...gallery_video, data: dataa };
    case DELETE_GALLERY_VIDEO:
      const data = gallery_video.data.filter(
        (data) => data.id !== payload.id.data.id
      );
      return { ...gallery_video, data };

    default:
      return gallery_video;
  }
}
export default gallery_video;
