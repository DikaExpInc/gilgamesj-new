import fetch from 'auth/FetchInterceptor'

const playerService = {}

playerService.getPlayerList = function () {
  return fetch({
    url: `/auth/getplayers`,
    method: 'get',
  })
}

playerService.deletePlayer = function (id) {
  return fetch({
    url: `/auth/getplayers/${id}`,
    method: 'delete',
  })
}

export default playerService
