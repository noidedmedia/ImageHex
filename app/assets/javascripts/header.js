// Setting stuff up.
function DropDown(el) {
  this.dd = el;
  this.opts = this.dd.find('ul.dropdown > li');
  this.initEvents();
}

DropDown.prototype = {
  initEvents: function() {
    var obj = this;

    // If you click on the user's name, the dropdown appears.
    // The function "clickOutside" is also called, this is
    // because the dropdown needs to be set up so that clicking
    // outside of it closes it.
    obj.dd.on('click', function(event) {
      $(this).toggleClass('active');
      clickOutside();
    });

    // If you click on one of the objects (defined above as the list items in the dropdown)
    // the other events (namely the dropdown closing) will not happen.
    obj.opts.on('click',function(event){
      event.stopPropagation();
    });
  }
};

// This function binds clicking outside of the dropdown to closing the dropdown.
function clickOutside() {

  // Creates an array of all classes applied to the element with an id of "dd".
  var classList = $('#dd').attr('class').split(/\s+/);

  // Loops through the array, checking if each value in the array
  // is "active". If it is, "clickoutside" will be binded to
  // removing the active class and then subsequently unbinding the 
  // "clickoutside" function to ensure that the dropdown won't be
  // toggled every time there's a click.
  for (var i = 0; i < classList.length; i++) {
    if (classList[i] == 'active') {
      $('#dd').bind('clickoutside', function(event) {
        $('#dd').removeClass('active');
        $('#dd').unbind('clickoutside');
      });
    }
  }
}

// Function runs when the document is "ready".
$(document).ready(function(){
  var dd = new DropDown($('#dd'));
});
