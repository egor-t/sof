$ ->
  $('.like-answer').bind('ajax:success', (e, data, status, xhr) ->
    likes = JSON.parse(xhr.responseText).data
    answer_likes = $(this).parents('.answer').find('span.likes')
    answer_likes.text(likes)
  )

  App.cable.subscriptions.create({ channel: 'AnswersChannel' }, {
    connected: ->
      @follow()

    follow: ->
      return unless gon.question_id
      @perform 'follow', id: gon.question_id

    received: (data)->
      answers = $('.answers')
      current_user_id = $('.user').data('currentUserId');
      answer = JSON.parse(data["answer"]);
      user_id = answer.user_id;
      if current_user_id != user_id
        answers.append(JST["templates/answer"]({
          answer: answer,
          current_user: current_user_id
        }))

  })