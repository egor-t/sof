$(document).ready ->
  $('.new_comment').bind('ajax:success', (e, data, status, xhr) ->
    comment_id = data.commentable_id
    if data.commentable_type == 'Question'
      $('.question-comments ul').append JST['templates/comment'](comment: data)
    else
      $('#answer_' + comment_id + ' .answer-comments ul').append JST['templates/comment'](comment: data)

    $('.new_comment textarea').val('')
  )

  App.cable.subscriptions.create { channel: 'CommentsChannel' },
    connected: ->
      @perform 'follow'
      return
    received: (data) ->
      current_user_id = $('.user').data('currentUserId')
      comment = JSON.parse(data['comment'])
      type = comment.commentable_type
      comment_id = comment.commentable_id
      user_id = comment.user_id
      if current_user_id != user_id
        switch type
          when 'Question'
            $('.question-comments ul').append JST['templates/comment'](comment: comment)
          when 'Answer'
            $('#answer_' + comment_id + ' .answer-comments ul').append JST['templates/comment'](comment: comment)
      return
  return