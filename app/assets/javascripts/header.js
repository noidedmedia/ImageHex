function DropDown(el) {
  this.dd = el;
  this.opts = this.dd.find('ul.dropdown > li');
  this.initEvents();
}

DropDown.prototype = {
  initEvents: function() {
    var obj = this;

    obj.dd.on('click', function(event) {
      $(this).toggleClass('active');
      clickOutside();
    });

    obj.opts.on('click',function(event){
      event.stopPropagation();
    });
  }
};

function clickOutside() {
  var classList = $('#dd').attr('class').split(/\s+/);
  console.log(classList);

  for (var i = 0; i < classList.length; i++) {
    if (classList[i] == 'active') {
      $('#dd').bind('clickoutside', function(event) {
        $('#dd').unbind('clickoutside');
        $('#dd').removeClass('active');
      });
    }
  }
}

$(document).ready(function(){
  var dd = new DropDown($('#dd'));
});
