# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  $('#register_user').on 'click', () ->
    $.ajax({
      url: 'users/create',
      method: 'POST',
      data: $('#user_form').serialize(),
      success: (response) ->
        if(response.status == 'success')
          window.location.href = '/'
        else
          toastr["error"](response.message)
    })