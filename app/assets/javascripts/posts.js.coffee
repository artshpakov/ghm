$ ->
  page = 1
  $('[role="load-more"]').click ->
    page++
    $.get $(@).data('url'), {page}, (posts) ->
      if posts
        $('[role="preview-list"]').append(posts)
      else
        $('[role="load-more"]').addClass('disabled')


  $('[role=like]').click ->
    [method, count] = if $(@).hasClass('liked')
      ['delete', +$(@).data('count')-1]
    else
      ['post', +$(@).data('count')+1]

    $.ajax(url: $(@).data('url'), type: method)

    $(@).data('count', count)
    $('[role=counter]', @).text(count)
    $(@).toggleClass('liked')
    $('.fa', @).toggleClass('fa-heart fa-heart-o')
