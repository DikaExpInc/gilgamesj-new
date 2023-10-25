import fetch from "auth/FetchInterceptor";

const newsService = {};

newsService.getBrowserList = function () {
  return fetch({
    url: "/browser",
    method: "get",
  });
};

newsService.addBrowser = function (data) {
  return fetch({
    url: "/browser/create",
    method: "post",
    data: data,
  });
};

newsService.getBrowser = function (id) {
  return fetch({
    url: "/browser/" + id,
    method: "get",
  });
};

newsService.deleteBrowser = function (id) {
  return fetch({
    url: "/browser/delete/" + id,
    method: "delete",
  });
};

newsService.updateBrowser = function (id, data) {
  return fetch({
    url: "/browser/edit/" + id,
    method: "put",
    data: data,
  });
};

export default newsService;
