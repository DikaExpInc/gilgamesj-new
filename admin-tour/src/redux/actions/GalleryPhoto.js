import {
  CREATE_GALLERY_PHOTO,
  DELETE_GALLERY_PHOTO,
  GET_ALL_GALLERY_PHOTO,
  GET_GALLERY_PHOTO,
  UPDATE_GALLERY_PHOTO,
} from "../constants/GalleryPhoto.js";

export const createGalleryPhoto = (data) => {
  return {
    type: CREATE_GALLERY_PHOTO,
    payload: data,
  };
};

export const deleteGalleryPhoto = (id) => {
  return {
    type: DELETE_GALLERY_PHOTO,
    payload: { id },
  };
};

export const getAllGalleryPhoto = (data) => {
  return {
    type: GET_ALL_GALLERY_PHOTO,
    payload: data,
  };
};

export const getGalleryPhoto = (data) => {
  return {
    type: GET_GALLERY_PHOTO,
    payload: data,
  };
};

export const updateGalleryPhoto = (data) => {
  return {
    type: UPDATE_GALLERY_PHOTO,
    payload: data,
  };
};
