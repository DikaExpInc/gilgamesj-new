import fetch from 'auth/FetchInterceptor'

const chatDetailService = {}

chatDetailService.getChatDetailList = function (chatid) {
  return fetch({
    url: `/chatdetail/${chatid}`,
    method: 'get',
  })
}

chatDetailService.addChatDetail = function (chatid, data) {
  return fetch({
    url: `/chatdetail/${chatid}/create`,
    method: 'post',
    data: data,
  })
}

chatDetailService.getChatDetail = function (chatid, id) {
  return fetch({
    url: `/chatdetail/${chatid}/${id}`,
    method: 'get',
  })
}

chatDetailService.deleteChatDetail = function (chatid, id) {
  return fetch({
    url: `/chatdetail/${chatid}/delete/${id}`,
    method: 'delete',
  })
}

chatDetailService.updateChatDetail = function (chatid, id, data) {
  return fetch({
    url: `/chatdetail/${chatid}/edit/${id}`,
    method: 'put',
    data: data,
  })
}

export default chatDetailService
