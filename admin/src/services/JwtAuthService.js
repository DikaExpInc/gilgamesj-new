import fetch from 'auth/FetchInterceptor'

const JwtAuthService = {}

JwtAuthService.login = function (data) {
  return fetch({
    url: '/auth/local?populate=*',
    method: 'post',
    headers: {
      'public-request': 'true',
    },
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

JwtAuthService.getPetugasByUser = function (id) {
  return fetch({
    url: '/officers?populate=*&filters[user]=' + id,
    method: 'get',
  })
}

export default JwtAuthService
