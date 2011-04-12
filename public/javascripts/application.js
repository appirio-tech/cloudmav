// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
  $('.flash').slideDown('fast', function() {
    $('.flash').delay(5000).slideUp('slow');
  });


  // Filter buttons for modules
  // 
  // General
  $("div.filter a").click(function(){
    $(this).parent().parent().find("li").removeClass("active");
    $(this).parent().addClass("active");
  });
  
  // Event Feed filter
  $(".event_load").hide();
  $("#events>li[data-type=event]").slideDown('slow');
  $("#more_events").click(function(){
    $(".more_events").hide();
    $(".event_load").slideDown();
  });
  $("#event_feed div.filter a").click(function(){
    $(".more_events").hide();

    $("#events>li[data-type=event]").slideUp('slow', function() {
      $(this).remove();
    });
    $(".event_load").slideDown();
  });
});




