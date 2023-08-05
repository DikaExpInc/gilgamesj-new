import React from "react";
import { Route, Switch, Redirect } from "react-router-dom";
import NewsList from "./news-list";
import AddNews from "./add-news";
import EditNews from "./edit-news";

const News = (props) => {
  const { match } = props;
  return (
    <Switch>
      <Redirect exact from={`${match.url}`} to={`${match.url}/list-news`} />
      <Route path={`${match.url}/add-news`} component={AddNews} />
      <Route path={`${match.url}/edit-news/:id`} component={EditNews} />
      <Route path={`${match.url}/list-news`} component={NewsList} />
    </Switch>
  );
};

export default News;
