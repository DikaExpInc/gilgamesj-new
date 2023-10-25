import fetch from 'auth/FetchInterceptor'

const theaterService = {}

theaterService.getTheaterList = function () {
  return fetch({
    url: '/theater',
    method: 'get',
  })
}

theaterService.addTheater = function (data) {
  return fetch({
    url: '/theater/create',
    method: 'post',
    data: data,
  })
}

theaterService.getTheater = function (id) {
  return fetch({
    url: '/theater/' + id,
    method: 'get',
  })
}

theaterService.deleteTheater = function (id) {
  return fetch({
    url: '/theater/delete/' + id,
    method: 'delete',
  })
}

theaterService.updateTheater = function (id, data) {
  return fetch({
    url: '/theater/edit/' + id,
    method: 'put',
    data: data,
  })
}

export default theaterService
