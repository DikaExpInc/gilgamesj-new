import fetch from 'auth/FetchInterceptor'

const phoneService = {}

phoneService.getPhoneList = function () {
  return fetch({
    url: '/phone',
    method: 'get',
  })
}

phoneService.addPhone = function (data) {
  return fetch({
    url: '/phone/create',
    method: 'post',
    data: data,
  })
}

phoneService.getPhone = function (id) {
  return fetch({
    url: '/phone/' + id,
    method: 'get',
  })
}

phoneService.deletePhone = function (id) {
  return fetch({
    url: '/phone/delete/' + id,
    method: 'delete',
  })
}

phoneService.updatePhone = function (id, data) {
  return fetch({
    url: '/phone/edit/' + id,
    method: 'put',
    data: data,
  })
}

export default phoneService
