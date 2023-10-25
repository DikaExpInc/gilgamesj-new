import React from "react";
import SocialMediasForm from "../social-media-form";

const EditSocialMedias = (props) => {
  return <SocialMediasForm mode="EDIT" param={props.match.params} />;
};

export default EditSocialMedias;
