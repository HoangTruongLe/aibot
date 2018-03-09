@ajax_func = (method, url, params = {}, is_async = false) ->
  BASE_URL = window.location.origin

  defer = $.Deferred()
  $.ajax
    type: method
    url: BASE_URL + url
    async: is_async
    data: params
    success: (data) ->
      defer.resolve data
    error: (xhr, textStatus, errorThrown) ->
      defer.reject()
    defer.promise()