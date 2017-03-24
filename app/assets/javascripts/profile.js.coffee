$ ->
  $('[role=avatar]').click ->
    $('[name=image]').click()

  $('[name=image]').change ->
    $('[role=avatar-form]').submit()
