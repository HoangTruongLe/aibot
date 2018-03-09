# $ ->
#   $('.m_text-save button').on 'click', ->
#     content   = $(this).parents('.m_editor-text-2').find('.wysiwyg-editor').html().trim()
#     emoji     = $(this).parents('.m_editor-text-2').find('#m_select-emoji').val()
#     if content
#       params =
#         content: content
#         chatbot_emotion_id: emoji

#       ajax_func('post', '/text_messages', params, true).done (result) ->
#         if result.status == 'success'
#           text = $(".m_editor-text-1[data-text-id='" + result.text.id + "']")
#           text.find('.textarea').html result.text.content
#           text.find('.m_editor-textarea-emoji span').text result.text.emotion

