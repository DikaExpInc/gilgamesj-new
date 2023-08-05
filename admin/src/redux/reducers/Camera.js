import {
  CREATE_CAMERA,
  DELETE_CAMERA,
  GET_ALL_CAMERA,
  GET_CAMERA,
  UPDATE_CAMERA,
} from "../constants/Camera";

const initialState = { data: [] };

function camera(camera = initialState, action) {
  const { type, payload } = action;
  switch (type) {
    case CREATE_CAMERA:
      return [camera, payload];
    case GET_ALL_CAMERA:
      return payload;
    case GET_CAMERA:
      return payload;
    case UPDATE_CAMERA:
      const dataa = camera.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          };
        } else {
          return data;
        }
      });
      return { ...camera, data: dataa };
    case DELETE_CAMERA:
      const data = camera.data.filter((data) => data.id !== payload.id.data.id);
      return { ...camera, data };

    default:
      return camera;
  }
}
export default camera;
