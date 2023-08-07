import fetch from 'auth/FetchInterceptor'

const taskService = {}

taskService.getTaskList = function () {
  return fetch({
    url: '/task',
    method: 'get',
  })
}

taskService.addTask = function (data) {
  return fetch({
    url: '/task/create',
    method: 'post',
    data: data,
  })
}

taskService.getTask = function (id) {
  return fetch({
    url: '/task/' + id,
    method: 'get',
  })
}

taskService.deleteTask = function (id) {
  return fetch({
    url: '/task/delete/' + id,
    method: 'delete',
  })
}

taskService.updateTask = function (id, data) {
  return fetch({
    url: '/task/edit/' + id,
    method: 'put',
    data: data,
  })
}

export default taskService
