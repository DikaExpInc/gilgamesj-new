import React from "react";
import { Route, Switch, Redirect } from "react-router-dom";
import PhoneList from "./phone-list";
import AddPhone from "./add-phone";
import EditPhone from "./edit-phone";

const Phone = (props) => {
  const { match } = props;
  return (
    <Switch>
      <Redirect exact from={`${match.url}`} to={`${match.url}/list-phone`} />
      <Route path={`${match.url}/add-phone`} component={AddPhone} />
      <Route path={`${match.url}/edit-phone/:id`} component={EditPhone} />
      <Route path={`${match.url}/list-phone`} component={PhoneList} />
    </Switch>
  );
};

export default Phone;
