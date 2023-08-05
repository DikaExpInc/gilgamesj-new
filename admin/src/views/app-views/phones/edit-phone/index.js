import React from "react";
import PhoneForm from "../phone-form";

const EditPhone = (props) => {
  return <PhoneForm mode="EDIT" param={props.match.params} />;
};

export default EditPhone;
