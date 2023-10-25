import React from "react";
import { Route, Switch, Redirect } from "react-router-dom";
import ContactList from "./contact-list";
import AddContact from "./add-contact";
import EditContact from "./edit-contact";

const Contact = (props) => {
  const { match } = props;
  return (
    <Switch>
      <Redirect exact from={`${match.url}`} to={`${match.url}/list-contact`} />
      <Route path={`${match.url}/add-contact`} component={AddContact} />
      <Route path={`${match.url}/edit-contact/:id`} component={EditContact} />
      <Route path={`${match.url}/list-contact`} component={ContactList} />
    </Switch>
  );
};

export default Contact;
