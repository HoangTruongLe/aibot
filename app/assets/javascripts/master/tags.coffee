# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.confirm_destroy').on 'click', ->
    name = $(this).data('name')
    path = $(this).data('path')

    $('#confirm_tag_text').text(name + 'を本当に削除しますか？')
    $('#destroy_tag').attr('href', path)
    $('#destroy_tag').attr('data-name', name)

    $('#tagDeleteModal').modal()