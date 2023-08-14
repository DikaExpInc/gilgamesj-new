import React from 'react'
import { Route, Switch, Redirect } from 'react-router-dom'
import LightList from './light-list'
import AddLight from './add-light'
import EditLight from './edit-light'

const Light = (props) => {
  const { match } = props
  return (
    <Switch>
      <Redirect exact from={`${match.url}`} to={`${match.url}/list-light`} />
      <Route path={`${match.url}/add-light`} component={AddLight} />
      <Route path={`${match.url}/edit-light/:id`} component={EditLight} />
      <Route path={`${match.url}/list-light`} component={LightList} />
    </Switch>
  )
}

export default Light
