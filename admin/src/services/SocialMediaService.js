import fetch from "auth/FetchInterceptor";

const socialMediaService = {};

socialMediaService.getSocialMediaList = function () {
  return fetch({
    url: "/socialmedia",
    method: "get",
  });
};

socialMediaService.addSocialMedia = function (data) {
  return fetch({
    url: "/socialmedia",
    method: "post",
    data: data,
  });
};

socialMediaService.getSocialMedia = function (id) {
  return fetch({
    url: "/socialmedia/" + id,
    method: "get",
  });
};

socialMediaService.deleteSocialMedia = function (id) {
  return fetch({
    url: "/socialmedia/" + id,
    method: "delete",
  });
};

socialMediaService.updateSocialMedia = function (id, data) {
  return fetch({
    url: "/socialmedia/" + id,
    method: "put",
    data: data,
  });
};

export default socialMediaService;
