import fetch from 'auth/FetchInterceptor'

const socialMediaCommentService = {}

socialMediaCommentService.getSocialMediaList = function (sosmedid) {
  return fetch({
    url: `/socialmediacomment/${sosmedid}`,
    method: 'get',
  })
}

socialMediaCommentService.addSocialMedia = function (sosmedid, data) {
  return fetch({
    url: `/socialmediacomment/${sosmedid}/create`,
    method: 'post',
    data: data,
  })
}

socialMediaCommentService.getSocialMedia = function (sosmedid, id) {
  return fetch({
    url: `/socialmediacomment/${sosmedid}/${id}`,
    method: 'get',
  })
}

socialMediaCommentService.deleteSocialMedia = function (sosmedid, id) {
  return fetch({
    url: `/socialmediacomment/${sosmedid}/delete/${id}`,
    method: 'delete',
  })
}

socialMediaCommentService.updateSocialMedia = function (sosmedid, id, data) {
  return fetch({
    url: `/socialmediacomment/${sosmedid}/edit/${id}`,
    method: 'put',
    data: data,
  })
}

export default socialMediaCommentService
