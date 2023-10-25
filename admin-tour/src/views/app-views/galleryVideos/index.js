import React from "react";
import { Route, Switch, Redirect } from "react-router-dom";
import GalleryVideoList from "./gallery-video-list";
import AddGalleryVideo from "./add-gallery-video";
import EditGalleryVideo from "./edit-gallery-video";

const GalleryVideo = (props) => {
  const { match } = props;
  return (
    <Switch>
      <Redirect
        exact
        from={`${match.url}`}
        to={`${match.url}/list-gallery-video`}
      />
      <Route
        path={`${match.url}/add-gallery-video`}
        component={AddGalleryVideo}
      />
      <Route
        path={`${match.url}/edit-gallery-video/:id`}
        component={EditGalleryVideo}
      />
      <Route
        path={`${match.url}/list-gallery-video`}
        component={GalleryVideoList}
      />
    </Switch>
  );
};

export default GalleryVideo;
