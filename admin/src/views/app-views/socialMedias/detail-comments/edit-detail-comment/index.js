import React from "react";
import DetailCommentForm from "../detail-comment-form";

const EditDetailComment = (props) => {
  return <DetailCommentForm mode="EDIT" param={props.match.params} />;
};

export default EditDetailComment;
