import fetch from 'auth/FetchInterceptor'

const galleryPhotoService = {}

galleryPhotoService.getGalleryPhotoList = function () {
  return fetch({
    url: '/galleryphoto',
    method: 'get',
  })
}

galleryPhotoService.addGalleryPhoto = function (data) {
  return fetch({
    url: '/galleryphoto/create',
    method: 'post',
    data: data,
  })
}

galleryPhotoService.getGalleryPhoto = function (id) {
  return fetch({
    url: '/galleryphoto/' + id,
    method: 'get',
  })
}

galleryPhotoService.deleteGalleryPhoto = function (id) {
  return fetch({
    url: '/galleryphoto/delete/' + id,
    method: 'delete',
  })
}

galleryPhotoService.updateGalleryPhoto = function (id, data) {
  return fetch({
    url: '/galleryphoto/edit/' + id,
    method: 'put',
    data: data,
  })
}

export default galleryPhotoService
