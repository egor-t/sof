$ ->
    $('.like-question').bind('ajax:success', (e, data, status, xhr) ->
        questionId = $(this).parents('.question').data('questionId')
        likes = JSON.parse(xhr.responseText).data
        $('.question-likes').html(likes)
    )

    questionsList = $('.questions-list')

    App.cable.subscriptions.create('QuestionsChannel', {
      connected: ->
        @perform 'follow'

      received: (data)->
        console.log data
        questionsList.append(data)
    })

