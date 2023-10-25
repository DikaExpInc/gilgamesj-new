import React from 'react'
import SocialMediaCommentForm from '../detail-comment-form'

const EditSocialMediaComment = (props) => {
  return <SocialMediaCommentForm mode="EDIT" param={props.match.params} />
}

export default EditSocialMediaComment
