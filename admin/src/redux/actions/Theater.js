import {
	GET_THEATER,
	GET_ALL_THEATER,
	CREATE_THEATER,
	UPDATE_THEATER,
	DELETE_THEATER,
} from '../constants/Theater.js'

export const createTheater = (data) => {
	return {
		type: CREATE_THEATER,
		payload: data,
	}
}

export const deleteTheater = (id) => {
	return {
		type: DELETE_THEATER,
		payload: { id },
	}
}

export const getAllTheater = (data) => {
	return {
		type: GET_ALL_THEATER,
		payload: data,
	}
}

export const getTheater = (data) => {
	return {
		type: GET_THEATER,
		payload: data,
	}
}

export const updateTheater = (data) => {
	return {
		type: UPDATE_THEATER,
		payload: data,
	}
}
