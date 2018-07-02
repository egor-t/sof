$(document).ready(function () {
    $('.like-question').bind('ajax:success', function (e, data, status, xhr) {
        var questionId = $(this).parents('.question').data('questionId');
        var likes = JSON.parse(xhr.responseText).data;
        // var questionLikes = $('#question_' + questionId + ' .valuation');
        $('.question-likes').html(likes);
    });
});


