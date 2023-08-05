import React from "react";
import { Route, Switch, Redirect } from "react-router-dom";
import TaskList from "./task-list";
import AddTask from "./add-task";
import EditTask from "./edit-task";

const Task = (props) => {
  const { match } = props;
  return (
    <Switch>
      <Redirect exact from={`${match.url}`} to={`${match.url}/list-task`} />
      <Route path={`${match.url}/add-task`} component={AddTask} />
      <Route path={`${match.url}/edit-task/:id`} component={EditTask} />
      <Route path={`${match.url}/list-task`} component={TaskList} />
    </Switch>
  );
};

export default Task;
