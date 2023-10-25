import React from "react";
import { Route, Switch, Redirect } from "react-router-dom";
import PreGamesList from "./pre-games-list";
import AddPreGames from "./add-pre-games";
import EditPreGames from "./edit-pre-games";

const PreGames = (props) => {
  const { match } = props;
  return (
    <Switch>
      <Redirect
        exact
        from={`${match.url}`}
        to={`${match.url}/list-pre-games`}
      />
      <Route path={`${match.url}/add-pre-games`} component={AddPreGames} />
      <Route
        path={`${match.url}/edit-pre-games/:id`}
        component={EditPreGames}
      />
      <Route path={`${match.url}/list-pre-games`} component={PreGamesList} />
    </Switch>
  );
};

export default PreGames;
