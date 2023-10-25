import FormComponent from "."

const EditForm = (props) => {
  return <FormComponent mode="EDIT" param={props.match.params} />
}
export default EditForm