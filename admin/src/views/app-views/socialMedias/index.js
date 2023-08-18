import React from 'react'
import { Route, Switch, Redirect } from 'react-router-dom'
import SocialMediaList from './social-media-list'
import AddSocialMedia from './add-social-media'
import EditSocialMedia from './edit-social-media'
import SocialMediaCommentList from './detail-comments/detail-comment-list'
import AddSocialMediaComment from './detail-comments/add-detail-comment'
import EditSocialMediaComment from './detail-comments/edit-detail-comment'

const SocialMedia = (props) => {
  const { match } = props
  return (
    <Switch>
      <Redirect
        exact
        from={`${match.url}`}
        to={`${match.url}/list-social-media`}
      />
      <Route
        path={`${match.url}/add-social-media`}
        component={AddSocialMedia}
      />
      <Route
        path={`${match.url}/edit-social-media/:id`}
        component={EditSocialMedia}
      />
      <Route
        path={`${match.url}/list-social-media`}
        component={SocialMediaList}
      />
      <Route
        exact
        path={`${match.url}/comment/:socialMediaId`}
        component={SocialMediaCommentList}
      />
      <Route
        path={`${match.url}/comment/:socialMediaId/add`}
        component={AddSocialMediaComment}
      />
      <Route
        path={`${match.url}/comment/:socialMediaId/:id/edit`}
        component={EditSocialMediaComment}
      />
    </Switch>
  )
}

export default SocialMedia
