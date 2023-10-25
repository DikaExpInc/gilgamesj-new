import React from "react";
import StageForm from "../stage-form";

const EditStage = (props) => {
  return <StageForm mode="EDIT" param={props.match.params} />;
};

export default EditStage;
