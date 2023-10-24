import { Switch, Redirect, Route } from 'react-router-dom'
import TheaterList from './List'
import AddForm from './form/AddForm'
import EditForm from './form/EditForm'

const Theater = (props) => {
	const { match } = props

	return (
		<Switch>
			<Redirect exact from={`${match.url}`} to={`${match.url}/list`} />

      <Route path={`${match.url}/list`} component={TheaterList} />
      <Route path ={`${match.url}/add`} component={AddForm} />
      <Route path={`${match.url}/edit/:id`} component={EditForm} />
		</Switch>
	)
}

export default Theater
