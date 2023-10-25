import React from "react";
import CameraForm from "../camera-form";

const EditCamera = (props) => {
  return <CameraForm mode="EDIT" param={props.match.params} />;
};

export default EditCamera;
