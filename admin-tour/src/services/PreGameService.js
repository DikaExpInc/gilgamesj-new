import fetch from "auth/FetchInterceptor";

const preGameService = {};

preGameService.getPreGameList = function () {
  return fetch({
    url: "/pregame",
    method: "get",
  });
};

preGameService.addPreGame = function (data) {
  return fetch({
    url: "/pregame/create",
    method: "post",
    data: data,
  });
};

preGameService.getPreGame = function (id) {
  return fetch({
    url: "/pregame/" + id,
    method: "get",
  });
};

preGameService.deletePreGame = function (id) {
  return fetch({
    url: "/pregame/delete/" + id,
    method: "delete",
  });
};

preGameService.updatePreGame = function (id, data) {
  return fetch({
    url: "/pregame/edit/" + id,
    method: "put",
    data: data,
  });
};

export default preGameService;
