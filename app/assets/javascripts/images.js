var ready;
ready = function(){
  hide =  $("div").filter(function(index){
    return $(this).data("showon");
    // Elements with data in the "showon" property are hidden from the start,
    // appearing only when the selector specified by showon is clicked
  });
  hide.each(function(){
    var that = this;
    $(this).hide();
    console.log($(that).data("showon"));
    var toggle = $($(this).data("showon"));
    console.log(toggle);
    $(toggle).on("click", function(){
      console.log("toggled!");
      $(that).show();
    });
  });
}
$(document).ready(ready);
$(document).on("page:load",ready);
