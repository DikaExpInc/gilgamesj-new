import React from "react";
import ContactForm from "../contact-form";

const EditContact = (props) => {
  return <ContactForm mode="EDIT" param={props.match.params} />;
};

export default EditContact;
