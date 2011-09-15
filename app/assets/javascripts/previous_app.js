// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
	console.log("doc rdy");
	$(".module_link").click(function() {
		console.log("module clicked");
	});

  $('.flash').slideDown('fast', function() {
    $('.flash').delay(5000).slideUp('slow');
  });

  // overlay
  $(".module_link").overlay({
    top: 160,
    mask: '#fff'
  });
});




