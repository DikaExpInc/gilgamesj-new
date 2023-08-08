import React from "react";
import TaskForm from "../task-form";

const EditTask = (props) => {
  return <TaskForm mode="EDIT" param={props.match.params} />;
};

export default EditTask;
