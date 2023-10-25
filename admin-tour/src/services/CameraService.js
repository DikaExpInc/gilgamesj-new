import fetch from 'auth/FetchInterceptor'

const cameraService = {}

cameraService.getCameraList = function () {
  return fetch({
    url: '/camera',
    method: 'get',
  })
}

cameraService.addCamera = function (data) {
  return fetch({
    url: '/camera/create',
    method: 'post',
    data: data,
  })
}

cameraService.getCamera = function (id) {
  return fetch({
    url: '/camera/' + id,
    method: 'get',
  })
}

cameraService.deleteCamera = function (id) {
  return fetch({
    url: '/camera/delete/' + id,
    method: 'delete',
  })
}

cameraService.updateCamera = function (id, data) {
  return fetch({
    url: '/camera/edit/' + id,
    method: 'put',
    data: data,
  })
}

export default cameraService
