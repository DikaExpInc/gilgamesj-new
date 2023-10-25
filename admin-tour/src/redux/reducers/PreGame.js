import {
  CREATE_PRE_GAME,
  DELETE_PRE_GAME,
  GET_ALL_PRE_GAME,
  GET_PRE_GAME,
  UPDATE_PRE_GAME,
} from "../constants/PreGame";

const initialState = { data: [] };

function preGame(preGame = initialState, action) {
  const { type, payload } = action;
  switch (type) {
    case CREATE_PRE_GAME:
      return { ...preGame, data: [...preGame.data, payload] };
    case GET_ALL_PRE_GAME:
      return { data: payload };
    case GET_PRE_GAME:
      return payload;
    case UPDATE_PRE_GAME:
      const updatedData = preGame.data.map((data) => {
        if (data.id === payload.id) {
          return {
            ...data,
            attributes: payload.attributes,
          };
        } else {
          return data;
        }
      });
      return { ...preGame, data: updatedData };
    case DELETE_PRE_GAME:
      const filteredData = preGame.data.filter(
        (data) => data.id !== payload.id
      );
      return { ...preGame, data: filteredData };
    default:
      return preGame;
  }
}
export default preGame;
