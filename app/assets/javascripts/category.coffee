# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('.clear-input-search').on 'click', ->
    $('#q_id_or_name_cont').val('')
    $('#q_activity_eq').val('')