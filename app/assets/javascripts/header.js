function DropDown(el) {
  this.dd = el;
  this.opts = this.dd.find('ul.dropdown > li');
  this.initEvents();
}

DropDown.prototype = {
  initEvents : function() {
    var obj = this;

    obj.dd.on('click', function(event){
      $(this).toggleClass('active');
    });
  }
};

$(window).ready(function() {
  var dd = new DropDown( $('#dd') );
});
