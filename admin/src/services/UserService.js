import fetch from 'auth/FetchInterceptor'

const userService = {}

userService.getUserList = function () {
  return fetch({
    url: `/users/player`,
    method: 'get',
  })
}

userService.deletePlayer = function (id) {
  return fetch({
    url: `/users/player/${id}`,
    method: 'delete',
  })
}

userService.addUser = function (stageID, data) {
  return fetch({
    url: `/users/${stageID}/create`,
    method: 'post',
    data: data,
  })
}

userService.getUser = function (stageID, id) {
  return fetch({
    url: `/users/${stageID}/find/${id}`,
    method: 'get',
  })
}

userService.deleteUser = function (stageID, id) {
  return fetch({
    url: `/users/${stageID}/delete/${id}`,
    method: 'delete',
  })
}

userService.deleteAllUserAndPlayer = function (stageID, id) {
  return fetch({
    url: `/users/deleteall`,
    method: 'delete',
  })
}

userService.updateUser = function (stageID, id, data) {
  return fetch({
    url: `/users/${stageID}/edit/${id}`,
    method: 'put',
    data: data,
  })
}

export default userService
