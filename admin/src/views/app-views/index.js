import React, { lazy, Suspense } from 'react'
import { Switch, Route, Redirect } from 'react-router-dom'
import Loading from 'components/shared-components/Loading'
import { APP_PREFIX_PATH } from 'configs/AppConfig'
// import { signOut } from 'redux/sagas/Auth'

export const AppViews = () => {
  return (
    <Suspense fallback={<Loading cover="content" />}>
      <Switch>
        <Route
          path={`${APP_PREFIX_PATH}/dashboard`}
          component={lazy(() => import(`./dashboards`))}
        />
        <Route
          path={`${APP_PREFIX_PATH}/faq`}
          component={lazy(() => import(`./faq`))}
        />
        <Route
          path={`${APP_PREFIX_PATH}/profile`}
          component={lazy(() => import(`./profile`))}
        />
        <Route
          path={`${APP_PREFIX_PATH}/users`}
          component={lazy(() => import(`./user-list`))}
        />
        <Route
          path={`${APP_PREFIX_PATH}/news`}
          component={lazy(() => import(`./news`))}
        />
        <Route
          path={`${APP_PREFIX_PATH}/social-medias`}
          component={lazy(() => import(`./socialMedias`))}
        />
        <Route
          path={`${APP_PREFIX_PATH}/gallery-photos`}
          component={lazy(() => import(`./galleryPhotos`))}
        />
        <Route
          path={`${APP_PREFIX_PATH}/gallery-videos`}
          component={lazy(() => import(`./galleryVideos`))}
        />
        <Route
          path={`${APP_PREFIX_PATH}/maps`}
          component={lazy(() => import(`./maps`))}
        />
        <Route
          path={`${APP_PREFIX_PATH}/cameras`}
          component={lazy(() => import(`./cameras`))}
        />
        <Route
          path={`${APP_PREFIX_PATH}/chats`}
          component={lazy(() => import(`./chats`))}
        />
        <Route
          path={`${APP_PREFIX_PATH}/phones`}
          component={lazy(() => import(`./phones`))}
        />
        <Route
          path={`${APP_PREFIX_PATH}/contacts`}
          component={lazy(() => import(`./contacts`))}
        />
        <Route
          path={`${APP_PREFIX_PATH}/stages`}
          component={lazy(() => import(`./stages`))}
        />
        <Route
          path={`${APP_PREFIX_PATH}/lights`}
          component={lazy(() => import(`./lights`))}
        />
        <Route
          path={`${APP_PREFIX_PATH}/settings`}
          component={lazy(() => import(`./settings`))}
        />
        <Redirect
          from={`${APP_PREFIX_PATH}`}
          to={`${APP_PREFIX_PATH}/dashboard`}
        />
      </Switch>
    </Suspense>
  )
}

export default React.memo(AppViews)
