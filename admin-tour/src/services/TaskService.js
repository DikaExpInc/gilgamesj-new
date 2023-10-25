import fetch from 'auth/FetchInterceptor'

const taskService = {}

taskService.getTaskList = function (stageID) {
  return fetch({
    url: `/task/${stageID}`,
    method: 'get',
  })
}

taskService.addTask = function (stageID, data) {
  return fetch({
    url: `/task/${stageID}/create`,
    method: 'post',
    data: data,
  })
}

taskService.getTask = function (stageID, id) {
  return fetch({
    url: `/task/${stageID}/find/${id}`,
    method: 'get',
  })
}

taskService.deleteTask = function (stageID, id) {
  return fetch({
    url: `/task/${stageID}/delete/${id}`,
    method: 'delete',
  })
}

taskService.updateTask = function (stageID, id, data) {
  return fetch({
    url: `/task/${stageID}/edit/${id}`,
    method: 'put',
    data: data,
  })
}

export default taskService
