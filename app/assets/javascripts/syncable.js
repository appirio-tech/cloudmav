
$(document).ready(function(){
  
  $(".sync_help").click(function() {
    $(this).parents("li").find(".help").slideDown();
    return false;
  });
  
  $(".sync_what_is").click(function() {
    $(this).parents("li").find(".what_is").slideDown();
    return false;
  });
    
  $(".close").click(function() {
    $(this).parent(".block-message").slideUp();
    return false;
  });
  
});