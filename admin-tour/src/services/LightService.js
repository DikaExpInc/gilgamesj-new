import fetch from 'auth/FetchInterceptor'

const lightService = {}

lightService.getLightList = function () {
  return fetch({
    url: '/light',
    method: 'get',
  })
}

lightService.addLight = function (data) {
  return fetch({
    url: '/light/create',
    method: 'post',
    data: data,
  })
}

lightService.getLight = function (id) {
  return fetch({
    url: '/light/' + id,
    method: 'get',
  })
}

lightService.deleteLight = function (id) {
  return fetch({
    url: '/light/delete/' + id,
    method: 'delete',
  })
}

lightService.updateLight = function (id, data) {
  return fetch({
    url: '/light/edit/' + id,
    method: 'put',
    data: data,
  })
}

export default lightService
