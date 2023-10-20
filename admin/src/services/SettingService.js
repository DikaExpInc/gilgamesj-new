import fetch from 'auth/FetchInterceptor'

const settingService = {}

settingService.getSettingList = function () {
  return fetch({
    url: `/setting`,
    method: 'get',
  })
}

settingService.addSetting = function (data) {
  return fetch({
    url: `/setting`,
    method: 'post',
    data: data,
  })
}

settingService.getSetting = function (id) {
  return fetch({
    url: `/setting/${id}`,
    method: 'get',
  })
}

settingService.deleteSetting = function (id) {
  return fetch({
    url: `/setting/${id}`,
    method: 'delete',
  })
}

settingService.updateSetting = function (id, data) {
  return fetch({
    url: `/setting/${id}`,
    method: 'put',
    data: data,
  })
}

settingService.updateSettingSeats = function (id, data) {
  return fetch({
    url: `/setting/editseat/${id}`,
    method: 'put',
    data: data,
  })
}

settingService.updateSettingSeatsIshtar = function (id, data) {
  return fetch({
    url: `/setting/editishtarcall/${id}`,
    method: 'put',
    data: data,
  })
}

export default settingService
