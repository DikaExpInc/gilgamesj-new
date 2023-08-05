import React from "react";
import ChatForm from "../chat-form";

const EditChat = (props) => {
  return <ChatForm mode="EDIT" param={props.match.params} />;
};

export default EditChat;
