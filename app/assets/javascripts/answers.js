$(document).ready(function () {
    $('.like-answer').bind('ajax:success', function (e, data, status, xhr) {
        var likes = JSON.parse(xhr.responseText).data;
        var answer_likes = $(this).parents('.answer').find('span.likes');
        answer_likes.text(likes)
    });
});


