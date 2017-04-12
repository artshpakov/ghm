//= require jquery
//= require jquery_ujs

//= require bootstrap

//= require react
//= require react_ujs
//= require_tree ./components

//= require_tree .


$(function() {
  if ($('#content').height() < 500) $('#content').height('500px'); // TODO temporarily

  $('[role="close-carousel"]').click(() => $('#banners').hide())
});
