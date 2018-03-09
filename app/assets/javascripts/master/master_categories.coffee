# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@set_parent_id = (id = '') ->
  $("#master_category_parent_id").val(id)
  if (id != '')
    $("#master_category_new_title").text("サブカテゴリを追加する")
  else
    $("#master_category_new_title").text("TOPカテゴリを追加する")
  $("#top_master_category").modal("show")

@edit_master_category = (id, parent_id, name, activity) ->
  edit_modal = $("#edit_master_category")

  $(edit_modal).find(".error-log").remove()
  error_fields = $(edit_modal).find('.field_with_errors')
  $(error_fields).removeClass('field_with_errors')

  $(edit_modal).find("#master_category_id").val(id)
  $(edit_modal).find("#master_category_parent_id").val(parent_id)
  $(edit_modal).find("#master_category_name").val(name)
  $(edit_modal).find("#master_category_activity_false").prop("checked", true)
  if (activity == 'true')
    $(edit_modal).find("#master_category_activity_true").prop("checked", true)
  $('#edit_master_category').find("form").attr('action', "/master/master_categories/" + id)
  $("#edit_master_category").modal("show")

@destroy_master_category = (id, name) ->
  $('#destroy_master_category').find("#delete_master_category").attr('href', "/master/master_categories/" + id)
  $('#destroy_master_category').find("#category_name_destroy").text(name)
  $('#category_name_destroy_error').text(name)
  $("#destroy_master_category").modal("show")

jQuery ->
  $('.easy-tree').EasyTree({
    i18n: {
            deleteNull: 'Select a node to delete',
            deleteConfirmation: 'Delete this node?',
            confirmButtonLabel: 'Okay',
            editNull: 'Select a node to edit',
            editMultiple: 'Only one node can be edited at one time',
            addMultiple: 'Select a node to add a new node',
            collapseTip: 'collapse',
            expandTip: 'expand',
            selectTip: 'select',
            unselectTip: 'unselet',
            editTip: 'edit',
            addTip: 'add',
            deleteTip: 'delete',
            cancelButtonLabel: 'cancle'
        }
    });
