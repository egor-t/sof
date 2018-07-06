$(document).ready ->
  $('.new_comment').bind('ajax:success', (e, data, status, xhr) ->
    if data.commentable_type == 'Question'
      $('.question-comments ul').append JST['templates/comment'](comment: data)
    else

      $('.answer-comments ul').append JST['templates/comment'](comment: data)

    $('.new_comment textarea').val('')
  )

  App.cable.subscriptions.create { channel: 'CommentsChannel' },
    connected: ->
      @perform 'follow'
      console.log '1 - connected'
      return
    received: (data) ->
      console.log '2 - received'
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
            $('.answer-comments ul').append JST['templates/comment'](comment: comment)
      return
  return