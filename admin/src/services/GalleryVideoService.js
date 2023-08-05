import fetch from "auth/FetchInterceptor";

const galleryVideoService = {};

galleryVideoService.getGalleryVideoList = function () {
  return fetch({
    url: "/galleryvideo",
    method: "get",
  });
};

galleryVideoService.addGalleryVideo = function (data) {
  return fetch({
    url: "/galleryvideo",
    method: "post",
    data: data,
  });
};

galleryVideoService.getGalleryVideo = function (id) {
  return fetch({
    url: "/galleryvideo/" + id,
    method: "get",
  });
};

galleryVideoService.deleteGalleryVideo = function (id) {
  return fetch({
    url: "/galleryvideo/" + id,
    method: "delete",
  });
};

galleryVideoService.updateGalleryVideo = function (id, data) {
  return fetch({
    url: "/galleryvideo/" + id,
    method: "put",
    data: data,
  });
};

export default galleryVideoService;
