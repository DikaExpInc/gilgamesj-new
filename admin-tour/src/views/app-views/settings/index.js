import React from "react";
import { Route, Switch, Redirect } from "react-router-dom";
import SettingList from "./setting-list/index";

const Setting = (props) => {
  const { match } = props;
  return (
    <Switch>
      <Redirect exact from={`${match.url}`} to={`${match.url}/list-setting`} />
      <Route path={`${match.url}/list-setting`} component={SettingList} />
    </Switch>
  );
};

export default Setting;
