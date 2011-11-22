// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){

  $('.alert-message.flash').slideDown('fast', function() {
    $('.alert-message').delay(5000).slideUp('slow');
  });

  // overlay
  $(".module_link").overlay({
    top: 160,
    mask: '#fff'
  }); 

});




