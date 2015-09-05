window.$ = window.jQuery = require 'jquery'
require 'bootstrap'

do ->
  host = 'denalocal.red:8000/api/sample'
  $.ajax
    url: 'http://' + host
    type: 'GET'
    dataType: 'jsonp'
    timeout: 10000
    success: (data) ->
      publisherList = $('section')
      publisherList.append data['status']
      return
    error: (data) ->
      return
    complete: (data) ->
