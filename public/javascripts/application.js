$(document).ready(function() {
  $('#back_to_top').click(function() {
    $.scrollTo(0, 800);
  });
  
  $('.close').click(function() {
    $('.close').parent().fadeOut();
  });
});
