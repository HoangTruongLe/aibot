# $ ->
#   $('.m_quote-save button').on 'click', ->
#     title       = $(this).parents('.m_editor-quote-2').find('.m_quote-title textarea').val().trim()
#     reference   = $(this).parents('.m_editor-quote-2').find('.m_quote-reference input').val().trim()
#     link        = $(this).parents('.m_editor-quote-2').find('.m_quote-link input').val().trim()
#     comment     = $(this).parents('.m_editor-quote-2').find('.m_quote-comment textarea').val().trim()
#     if title
#       $(this).parents('.m_editor-quote-2').find('.m_quote-title textarea').removeClass 'm_required-field'

#       params =
#         content: title
#         quote_source: reference
#         quote_url: link
#         referral_comment: comment

#       ajax_func('post', '/quotes', params, true).done (result) ->
#         if result.status == 'success'
#           quote = $(".m_editor-quote-1[data-quote-id='" + result.quote.id + "']")
#           quote.find('.m_quote-title strong').text result.quote.content
#           quote.find('.m_quote-reference small').text result.quote.quote_source
#           quote.find('.m_quote-reference a').attr 'href', result.quote.quote_url
#           quote.find('.m_quote-comment').text result.quote.referral_comment
#     else
#       $(this).parents('.m_editor-quote-2').find('.m_quote-title textarea').addClass 'm_required-field'

