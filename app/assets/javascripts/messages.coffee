# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('.clear-input-search').on 'click', ->
    $('#q_id_or_name_or_tags_cont').val('')
    $('#q_id_or_email_or_name_cont').val('')
    $('#q_category_name_eq').val('')
    $('#q_name_cont').val('')

  $('.clear-input-search-2').on 'click', ->
    $('#q_keyword_master_category_name_or_keyword_name_or_tags_name_or_keywords_name_cont').val('')
    $('#q_message_type_eq').val('')
    $('#q_activity_eq').val('')

  $('.clear-input-search-p').on 'click', ->
    $('.input-search-primary').val('')

  $('.clear-input-search-r').on 'click', ->
    $('.input-search-relative').val('')

$ ->
  $('body').on 'click', '.edit-link-card-btn', ->
    parent = $(this).parents('div[class="m_link-card"]');
    $(parent).find('.m_link-card-review').addClass('hidden');
    $(parent).find('.m_link-card-edit').removeClass('hidden');
    tr_parent = $(this).closest('tr');
    $(tr_parent).addClass('ui-state-disabled');

  $('body').on 'click', '.edit-quote-btn', ->
    parent = $(this).parents('div[class="m_quote"]');
    $(parent).find('.m_quote-review').addClass('hidden');
    $(parent).find('.m_quote-edit').removeClass('hidden');
    tr_parent = $(this).closest('tr');
    $(tr_parent).addClass('ui-state-disabled');

  $('body').on 'click', '.edit-message_form-btn', ->
    parent = $(this).parents('div[class="m_message_form"]');
    $(parent).find('.m_message_form-review').addClass('hidden');
    $(parent).find('.m_message_form-edit').removeClass('hidden');
    tr_parent = $(this).closest('tr');
    $(tr_parent).addClass('ui-state-disabled');

  $('body').on 'click', '.edit-text-message-btn', ->
    parent = $(this).parents('div[class="m_text-message"]');
    $(parent).find('.m_text-message-review').addClass('hidden');
    selector = $(parent).find('.m_text-message-edit');
    init_editor(selector);
    $('.wysiwyg-editor').attr("onclick", '$(this).focus();');
    $(selector).removeClass('hidden');
    tr_parent = $(this).closest('tr');
    $(tr_parent).addClass('ui-state-disabled');

  $('body').on 'click', '.edit-question-btn', ->
    parent = $(this).parents('div[class="m_question"]');
    $(parent).find('.m_question-review').addClass('hidden');
    $(parent).find('.m_question-edit').removeClass('hidden');
    tr_parent = $(this).closest('tr');
    $(tr_parent).addClass('ui-state-disabled');
    $(".answer-keyword").select2({
      placeholder: "キーワードを選択してください",
      allowClear: true,
      width: '100%'
    });

  $('body').on 'click', '.edit-product-message-btn', ->
    parent = $(this).parents('div[class="m_product-message"]');
    $(parent).find('.m_product-message-review').addClass('hidden');
    $(parent).find('.m_product-message-edit').removeClass('hidden');
    tr_parent = $(this).closest('tr');
    $(tr_parent).addClass('ui-state-disabled');

  $('body').on 'click', '.edit-form-message-btn', ->
    parent = $(this).parents('div[class="m_form-message"]');
    $(parent).find('.m_form-message-review').addClass('hidden');
    $(parent).find('.m_form-message-edit').removeClass('hidden');
    tr_parent = $(this).closest('tr');
    $(tr_parent).addClass('ui-state-disabled');

  $('body').on 'click', '.btn-delete-msg-content', ->
    link = $(this).data('link');
    type = $(this).data('type');
    $('#destroy_message_content').find("#delete_message_content_id").attr('href', link)
    $('#destroy_message_content').find("#message_type").text("この" + type + "を本当に削除しますか？")
    $("#destroy_message_content").modal("show")

$ ->
  $('#m_textarea').richText
    bold: true
    italic: true
    underline: true
    leftAlign: true
    centerAlign: true
    rightAlign: true
    ol: false
    ul: false
    heading: true
    fontColor: true
    imageUpload: false
    fileUpload: false
    videoEmbed: false
    urls: false
    table: false
    removeStyles: false
    code: true
    colors: []
    fileHTML: ''
    imageHTML: ''
    useSingleQuotes: false

  window.emojiPicker = new EmojiPicker(
    emojiable_selector: '[data-emojiable=true]'
    assetsPath: './../assets/img'
    popupButtonClasses: 'fa fa-smile-o')
  window.emojiPicker.discover()

  $('.m_slide_list').slick
    speed: 300
    dots: true
    arrows: false
    slidesToShow: 1
    slidesToScroll: 1
    focusOnSelect: true
    autoplay: true

  Dropzone.options.photoDropzone =
    url: '#'
    previewsContainer: '.dropzone-previews'
    uploadMultiple: true
    parallelUploads: 100
    maxFiles: 100

  elements =
    # '.m_editor-question-1': '.m_editor-question-1 .m_editor-question-textarea'
#    '.m_editor-photo-1': '.m_editor-photo-1 .m_photo-list'
#    '.m_editor-video-1': '.m_editor-video-1 .m_editor-video-wrapper'
  for parent, elem of elements
    answersHeight = $(elem).height()
    topPositionActionGroup = answersHeight / 2 + 20
    $("#{parent} .m_editor-action").css('top', topPositionActionGroup + 'px')


@remove_card = (data) =>
  $(data).closest('tr')[0].remove()

@show_card_review = (data) =>
  tr_parent = $(data).closest('tr');
  $(tr_parent).removeClass('ui-state-disabled');
  $(tr_parent).find('.review').removeClass('hidden');
  $(tr_parent).find('.editor').addClass('hidden');

@delete_message_content = ->
  $('#destroy_message_content').modal('hide');
  $('#spinner').show();

SortableRanking = activate: (selector, rank_callback) ->
  $(selector).sortable stop: rank_callback, cancel: ".ui-state-disabled"
  return

sortable = ->
  m_content_table = $('#m_content')
  if m_content_table.length > 0
    SortableRanking.activate m_content_table.find('tbody'), (event, ui) ->
      if (ui.item.data().msg_content_id != undefined)
        data = message_content:
          id: ui.item.data().msg_content_id
          row_order_position: ui.item.index()
        data[$('meta[name="csrf-param"]').attr('content')] = $('meta[name="csrf-token"]').attr('content')
        $.ajax
          url: ui.item.data().path
          type: 'PUT'
          data: data
          datatype: 'json'
          error: (xhr, status, error) ->
            # alert error
            return
        return
  return

$(document).ready(sortable)
$(document).on 'turbolinks:load', sortable

@checkValidField = (button, parent, input) ->
  parent = $(button).parents(parent)
  input = parent.find(input)
  if !$(input).val()
    parent.find('p.invalid-field').show()
    return false
  else if $(input).val()
    parent.find('p.invalid-field').hide()
