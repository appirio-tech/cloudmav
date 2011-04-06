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
 // $("#more_activity").click(function(){
 //   $(".more_activity").hide();
 //   $(".activity_load").slideDown();
 // });
  $("#event_feed div.filter a").click(function(){
//alert("filter");
    //$(".more_activity").hide();

   //$("#events>li[data-type=event]").slideUp('slow').remove();
    $("#events>li[data-type=event]").slideUp('slow', function() {
      $(this).remove();
    });
    $(".event_load").slideDown();
  });
});




