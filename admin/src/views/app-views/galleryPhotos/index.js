import React from "react";
import { Route, Switch, Redirect } from "react-router-dom";
import GalleryPhotoList from "./gallery-photo-list";
import AddGalleryPhoto from "./add-gallery-photo";
import EditGalleryPhoto from "./edit-gallery-photo";

const GalleryPhoto = (props) => {
  const { match } = props;
  return (
    <Switch>
      <Redirect
        exact
        from={`${match.url}`}
        to={`${match.url}/list-gallery-photo`}
      />
      <Route
        path={`${match.url}/add-gallery-photo`}
        component={AddGalleryPhoto}
      />
      <Route
        path={`${match.url}/edit-gallery-photo/:id`}
        component={EditGalleryPhoto}
      />
      <Route
        path={`${match.url}/list-gallery-photo`}
        component={GalleryPhotoList}
      />
    </Switch>
  );
};

export default GalleryPhoto;
