var ready;
ready = function(){
  $("#image_list_container").justifiedGallery({
    rowHeight: 230,
    margins: 10
  });
}

$(document).ready(ready);
$(document).on("page:load", ready);
