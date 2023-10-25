import React from "react";
import DetailChatForm from "../detail-chat-form";

const EditDetailChat = (props) => {
  return <DetailChatForm mode="EDIT" param={props.match.params} />;
};

export default EditDetailChat;
