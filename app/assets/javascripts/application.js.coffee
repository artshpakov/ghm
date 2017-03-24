#= require jquery
#= require jquery_ujs
#= require_tree .

$ ->
  $('[role=avatar]').click ->
    $('[name=image]').click()

  $('[name=image]').change ->
    $('[role=avatar-form]').submit()
