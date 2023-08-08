import fetch from 'auth/FetchInterceptor'

const stageService = {}

stageService.getStageList = function () {
  return fetch({
    url: '/stage',
    method: 'get',
  })
}

stageService.addStage = function (data) {
  return fetch({
    url: '/stage/create',
    method: 'post',
    data: data,
  })
}

stageService.getStage = function (id) {
  return fetch({
    url: '/stage/' + id,
    method: 'get',
  })
}

stageService.deleteStage = function (id) {
  return fetch({
    url: '/stage/delete/' + id,
    method: 'delete',
  })
}

stageService.updateStage = function (id, data) {
  return fetch({
    url: '/stage/edit/' + id,
    method: 'put',
    data: data,
  })
}

export default stageService
