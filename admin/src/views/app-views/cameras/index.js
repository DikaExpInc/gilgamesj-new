import React from "react";
import { Route, Switch, Redirect } from "react-router-dom";
import CameraList from "./camera-list";
import AddCamera from "./add-camera";
import EditCamera from "./edit-camera";

const Camera = (props) => {
  const { match } = props;
  return (
    <Switch>
      <Redirect exact from={`${match.url}`} to={`${match.url}/list-camera`} />
      <Route path={`${match.url}/add-camera`} component={AddCamera} />
      <Route path={`${match.url}/edit-camera/:id`} component={EditCamera} />
      <Route path={`${match.url}/list-camera`} component={CameraList} />
    </Switch>
  );
};

export default Camera;
