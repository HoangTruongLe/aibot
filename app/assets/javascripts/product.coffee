# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@clearFilter = ->
  $('.search-input').val ''
  $('.select-search').val ''
  $('.select-search').focus()

$ ->
  # We can attach the `fileselect` event to all file inputs on the page
  $(document).on 'change', 'input[name=csv_file]', ->
    input = $(this)
    label = input.val().replace(/\\/g, '/').replace(/.*\//, '')
    input.trigger 'fileselect', [ label ]

  # We can watch for our custom `fileselect` event like this
  $(document).ready ->
    $('input[name=csv_file]').on 'fileselect', (event, label) ->
      input = $('.label-csv-file')
      if input.length
        input.text label
        $('#import-csv-button').prop 'disabled', false
        $('#import-csv-button').addClass 'csv-import-hover'
      else
        alert label

    $('#dtp-start-time').datetimepicker
      format: 'YYYY/MM/DD'
      locale: 'ja'
    $('#dtp-end-time').datetimepicker
      format: 'YYYY/MM/DD'
      locale: 'ja'