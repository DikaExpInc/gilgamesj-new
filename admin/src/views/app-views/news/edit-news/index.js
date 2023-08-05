import React from "react";
import NewsForm from "../news-form";

const EditProduct = (props) => {
  return <NewsForm mode="EDIT" param={props.match.params} />;
};

export default EditProduct;
