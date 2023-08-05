import React from "react";
import GalleryPhotoForm from "../gallery-photo-form";

const EditGalleryPhoto = (props) => {
  return <GalleryPhotoForm mode="EDIT" param={props.match.params} />;
};

export default EditGalleryPhoto;
