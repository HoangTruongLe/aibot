# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@update_keyword = (id, name, activity, cpc, master_category_id) ->
  edit_modal = $("#update_keyword_modal")
  $(edit_modal).find(".error-log").remove()
  error_fields = $(edit_modal).find('.field_with_errors')
  $(error_fields).removeClass('field_with_errors')
  $(edit_modal).find("#keyword_id").val(id)
  $(edit_modal).find("#keyword_name").val(name)
  $(edit_modal).find("#keyword_cpc").val(cpc)
  $(edit_modal).find("#keyword_activity_false").prop("checked", true)
  $(edit_modal).find("#keyword_master_category_id").val(master_category_id)
  if (activity == 'true')
      $(edit_modal).find("#keyword_activity_true").prop("checked", true)
  $('#update_keyword_modal').find("form").attr('action', "/master/keywords/" + id)

  $("#update_keyword_modal").modal("show")

@delete_keyword = (id, name) ->
  $('#destroy_keyword_modal').find("#delete_keyword").attr('href', "/master/keywords/" + id)
  $('#destroy_keyword_modal').find("#keyword_name_destroy").text(name)
  $("#destroy_keyword_modal").modal("show")
  $("#destroy_keyword_modal").modal("show")
  $("#destroy_error").find("#keyword_destroy_error").text(name)
