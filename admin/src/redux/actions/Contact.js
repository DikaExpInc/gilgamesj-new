import {
  CREATE_CONTACT,
  DELETE_CONTACT,
  GET_ALL_CONTACT,
  GET_CONTACT,
  UPDATE_CONTACT,
} from "../constants/Contact.js";

export const createContact = (data) => {
  return {
    type: CREATE_CONTACT,
    payload: data,
  };
};

export const deleteContact = (id) => {
  return {
    type: DELETE_CONTACT,
    payload: { id },
  };
};

export const getAllContact = (data) => {
  return {
    type: GET_ALL_CONTACT,
    payload: data,
  };
};

export const getContact = (data) => {
  return {
    type: GET_CONTACT,
    payload: data,
  };
};

export const updateContact = (data) => {
  return {
    type: UPDATE_CONTACT,
    payload: data,
  };
};
