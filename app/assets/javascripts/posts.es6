$(function() {

  let page = 1;
  $('[role="load-more"]').click(function() {
    page++;
    $.get($(this).data('url'), {page: page}, function(posts) {
      if (posts) {
        $('[role="preview-list"]').append(posts);
      } else {
        $('[role="load-more"]').addClass('disabled');
      }
    });
  });

})
