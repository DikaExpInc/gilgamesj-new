import { all, takeEvery, put, fork, call } from 'redux-saga/effects'
import { AUTH_TOKEN, SIGNIN, SIGNOUT } from '../constants/Auth'
import { showAuthMessage, authenticated, signOutSuccess } from '../actions/Auth'
import JwtAuthService from 'services/JwtAuthService'

export function* signIn() {
  yield takeEvery(SIGNIN, function* ({ payload }) {
    const { email, password } = payload
    try {
      const user = yield call(JwtAuthService.login, email, password)
      if (user.message) {
        yield put(showAuthMessage(user.message))
      } else {
        localStorage.setItem(AUTH_TOKEN, user.user.uid)
        yield put(authenticated(user.user.uid))
      }
    } catch (err) {
      yield put(showAuthMessage(err))
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
