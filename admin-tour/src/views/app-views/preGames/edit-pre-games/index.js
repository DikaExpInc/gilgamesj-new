import React from "react";
import PreGamesForm from "../pre-games-form";

const EditPreGames = (props) => {
  return <PreGamesForm mode="EDIT" param={props.match.params} />;
};

export default EditPreGames;
