# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->

  toastr.options = {
    "closeButton": true,
    "debug": false,
    "positionClass": "toast-bottom-right",
    "onclick": null,
    "showDuration": "300",
    "hideDuration": "1000",
    "timeOut": "5000",
    "extendedTimeOut": "1000",
    "showEasing": "swing",
    "hideEasing": "linear",
    "showMethod": "fadeIn",
    "hideMethod": "fadeOut"
  }

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