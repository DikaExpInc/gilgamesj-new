import fetch from 'auth/FetchInterceptor'

const JwtAuthService = {}

JwtAuthService.login = function (data) {
  console.log(data)
  return fetch({
    url: '/auth/signin',
    method: 'post',
    data: data,
  })
}

JwtAuthService.getUser = function () {
  return fetch({
    url: '/users/me?populate=*',
    method: 'get',
  })
}

JwtAuthService.updateUser = function (data) {
  return fetch({
    url: '/users-permissions/users/me/update-data',
    method: 'put',
    data: data,
  })
}

export default JwtAuthService
