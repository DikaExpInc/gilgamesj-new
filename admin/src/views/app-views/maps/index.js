import React from "react";
import { Route, Switch, Redirect } from "react-router-dom";
import MapsList from "./maps-list";
import AddMaps from "./add-maps";
import EditMaps from "./edit-maps";

const Maps = (props) => {
  const { match } = props;
  return (
    <Switch>
      <Redirect exact from={`${match.url}`} to={`${match.url}/list-maps`} />
      <Route path={`${match.url}/add-maps`} component={AddMaps} />
      <Route path={`${match.url}/edit-maps/:id`} component={EditMaps} />
      <Route path={`${match.url}/list-maps`} component={MapsList} />
    </Switch>
  );
};

export default Maps;
