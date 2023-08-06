import { all, takeEvery, put, fork, call } from 'redux-saga/effects'
import { AUTH_TOKEN, SIGNIN, SIGNOUT } from '../constants/Auth'
import { showAuthMessage, authenticated, signOutSuccess } from '../actions/Auth'
import JwtAuthService from 'services/JwtAuthService'

export function* signIn() {
  yield takeEvery(SIGNIN, function* ({ payload }) {
    const { email, password } = payload
    try {
      const user = yield call(JwtAuthService.login, {
        email: email,
        password: password,
      })
      localStorage.setItem(AUTH_TOKEN, user.data.token)
      yield put(authenticated(user.data.token))
    } catch (err) {
      console.log(err)
      let errorMessage = 'An error occurred.'
      if (err.response && err.response.data && err.response.data.message) {
        errorMessage = err.response.data.message
      }
      yield put(showAuthMessage(errorMessage))
    }
  })
}

export function* signOut() {
  yield takeEvery(SIGNOUT, function* () {
    try {
      localStorage.removeItem(AUTH_TOKEN)
      yield put(signOutSuccess())
    } catch (err) {
      yield put(showAuthMessage(err))
    }
  })
}

export default function* rootSaga() {
  yield all([fork(signIn), fork(signOut)])
}
