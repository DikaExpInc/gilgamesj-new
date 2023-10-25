import React from 'react'
import LightForm from '../light-form'

const EditLight = (props) => {
  return <LightForm mode="EDIT" param={props.match.params} />
}

export default EditLight
