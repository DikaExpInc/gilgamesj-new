import {
  CREATE_GALLERY_VIDEO,
  DELETE_GALLERY_VIDEO,
  GET_ALL_GALLERY_VIDEO,
  GET_GALLERY_VIDEO,
  UPDATE_GALLERY_VIDEO,
} from "../constants/GalleryVideo.js";

export const createGalleryVideo = (data) => {
  return {
    type: CREATE_GALLERY_VIDEO,
    payload: data,
  };
};

export const deleteGalleryVideo = (id) => {
  return {
    type: DELETE_GALLERY_VIDEO,
    payload: { id },
  };
};

export const getAllGalleryVideo = (data) => {
  return {
    type: GET_ALL_GALLERY_VIDEO,
    payload: data,
  };
};

export const getGalleryVideo = (data) => {
  return {
    type: GET_GALLERY_VIDEO,
    payload: data,
  };
};

export const updateGalleryVideo = (data) => {
  return {
    type: UPDATE_GALLERY_VIDEO,
    payload: data,
  };
};
