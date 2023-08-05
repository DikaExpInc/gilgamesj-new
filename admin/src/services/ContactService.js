import fetch from "auth/FetchInterceptor";

const contactService = {};

contactService.getContactList = function () {
  return fetch({
    url: "/contact",
    method: "get",
  });
};

contactService.addContact = function (data) {
  return fetch({
    url: "/contact",
    method: "post",
    data: data,
  });
};

contactService.getContact = function (id) {
  return fetch({
    url: "/contact/" + id,
    method: "get",
  });
};

contactService.deleteContact = function (id) {
  return fetch({
    url: "/contact/" + id,
    method: "delete",
  });
};

contactService.updateContact = function (id, data) {
  return fetch({
    url: "/contact/" + id,
    method: "put",
    data: data,
  });
};

export default contactService;
