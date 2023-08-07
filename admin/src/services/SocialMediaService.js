import fetch from 'auth/FetchInterceptor'

const socialMediaService = {}

socialMediaService.getSocialMediaList = function () {
  return fetch({
    url: '/socialmedia',
    method: 'get',
  })
}

socialMediaService.addSocialMedia = function (data) {
  return fetch({
    url: '/socialmedia/create',
    method: 'post',
    data: data,
  })
}

socialMediaService.getSocialMedia = function (id) {
  return fetch({
    url: '/socialmedia/' + id,
    method: 'get',
  })
}

socialMediaService.deleteSocialMedia = function (id) {
  return fetch({
    url: '/socialmedia/delete/' + id,
    method: 'delete',
  })
}

socialMediaService.updateSocialMedia = function (id, data) {
  return fetch({
    url: '/socialmedia/edit/' + id,
    method: 'put',
    data: data,
  })
}

export default socialMediaService
