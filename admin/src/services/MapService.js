import fetch from "auth/FetchInterceptor";

const mapService = {};

mapService.getMapList = function () {
  return fetch({
    url: "/map",
    method: "get",
  });
};

mapService.addMap = function (data) {
  return fetch({
    url: "/map",
    method: "post",
    data: data,
  });
};

mapService.getMap = function (id) {
  return fetch({
    url: "/map/" + id,
    method: "get",
  });
};

mapService.deleteMap = function (id) {
  return fetch({
    url: "/map/" + id,
    method: "delete",
  });
};

mapService.updateMap = function (id, data) {
  return fetch({
    url: "/map/" + id,
    method: "put",
    data: data,
  });
};

export default mapService;
