$(document).ready(function () {
    $('.like-answer').bind('ajax:success', function (e, data, status, xhr) {
        var likes = JSON.parse(xhr.responseText).data;
        $('.likes').html(likes);
    });
});


