import React from 'react'
import { Route, Switch, Redirect } from 'react-router-dom'
import StageList from './stage-list'
import AddStage from './add-stage'
import EditStage from './edit-stage'
import TaskList from './tasks/task-list'
import AddTask from './tasks/add-task'
import EditTask from './tasks/edit-task'

const Stage = (props) => {
  const { match } = props
  return (
    <Switch>
      <Redirect exact from={`${match.url}`} to={`${match.url}/list-stage`} />
      <Route path={`${match.url}/add-stage`} component={AddStage} />
      <Route path={`${match.url}/edit-stage/:id`} component={EditStage} />
      <Route path={`${match.url}/list-stage`} component={StageList} />
      <Route
        exact
        path={`${match.url}/detail-task/:stageId`}
        component={TaskList}
      />
      <Route
        path={`${match.url}/detail-task/:stageId/add`}
        component={AddTask}
      />
      <Route
        path={`${match.url}/detail-task/:stageId/:id/edit`}
        component={EditTask}
      />
    </Switch>
  )
}

export default Stage
