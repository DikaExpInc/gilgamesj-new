import React from "react";
import MapsForm from "../maps-form";

const EditMaps = (props) => {
  return <MapsForm mode="EDIT" param={props.match.params} />;
};

export default EditMaps;
