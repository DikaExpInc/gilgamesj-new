import React from "react";
import GalleryVideoForm from "../gallery-video-form";

const EditGalleryVideo = (props) => {
  return <GalleryVideoForm mode="EDIT" param={props.match.params} />;
};

export default EditGalleryVideo;
