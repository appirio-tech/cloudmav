
$(document).ready(function(){
  
  $(".sync_help").click(function() {
    $(this).parents("li").find(".block-message").slideDown();
    return false;
  });
  
  $(".close").click(function() {
    $(this).parent(".block-message").slideUp();
    return false;
  });
  
});