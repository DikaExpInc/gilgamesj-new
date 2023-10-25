import fetch from 'auth/FetchInterceptor'

const chatService = {}

chatService.getChatList = function () {
  return fetch({
    url: '/chat',
    method: 'get',
  })
}

chatService.addChat = function (data) {
  return fetch({
    url: '/chat/create',
    method: 'post',
    data: data,
  })
}

chatService.getChat = function (id) {
  return fetch({
    url: '/chat/' + id,
    method: 'get',
  })
}

chatService.deleteChat = function (id) {
  return fetch({
    url: '/chat/delete/' + id,
    method: 'delete',
  })
}

chatService.updateChat = function (id, data) {
  return fetch({
    url: '/chat/edit/' + id,
    method: 'put',
    data: data,
  })
}

export default chatService
