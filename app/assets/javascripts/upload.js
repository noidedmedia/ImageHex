function customSelect() {
  var customselect = $('select.custom-select');

  // Create the custom select menus from the existing select input.
  customselect.each(function() {
    var _this = $(this);
    var listid = _this.attr('id'),
    groups = _this.children('optgroup'),
      theoptions = "",
      startingoption = "",
      customselect = "";
    
    // Check if there are option groups 
    if (groups.length) {
      groups.each(function() {

        var curgroup = $(this);
        var curname = curgroup.attr('label');

        // Open the option group
        theoptions += '<li class="optgroup">' + curname + '</li>';

        // Get the options
        curgroup.children('option').each(function() {
          var curopt = $(this);
          var curval = curopt.attr('value');
          var curhtml = curopt.html();
          var isselected = curopt.attr('selected');
          
          if (isselected === 'selected') {
            startingoption = curhtml;
            theoptions += '<li class="selected" data-value="' + curval + '">' + curhtml + '</li>';
          } else {
            theoptions += '<li data-value="' + curval + '">' + curhtml + '</li>';
          }
        });
      });

      // Add options not in a group to the top of the list
      _this.children('option').each(function() {
        var curopt = $(this);
        var curval = curopt.attr('value');
        var curhtml = curopt.html();
        var isselected = curopt.attr('selected');

        if (isselected === 'selected') {
          startingoption = curhtml;
          theoptions = '<li class="selected" data-value="' + curval + '">' + curhtml + '</li>' + theoptions;
        } else {
          theoptions = '<li data-value="' + curval + '">' + curhtml + '</li>' + theoptions;
        }
      });
    } else {
      _this.children('option').each(function() {
        var curopt = $(this);
        var curval = curopt.attr('value');
        var curhtml = curopt.html();
        var isselected = curopt.attr('selected');

        if (isselected === 'selected') {
          startingoption = curhtml;
          theoptions += '<li class="selected" data-value="' + curval + '">' + curhtml + '</li>';
        } else {
          theoptions += '<li data-value="' + curval + '">' + curhtml + '</li>';
        }
      });
    }

    // Build the custom select
    customselect = '<div class="dropdown-container"><div class="dropdown-select"><span>' + startingoption + '</span></div><ul class="dropdown-select-ul" data-role="' + listid +'">' + theoptions + '</ul></div>';
    
    // Append it after the actual select
    $(customselect).insertAfter(_this);
  });
  
  var selectdd = $('.dropdown-select');
  var selectul = $('.dropdown-select-ul');
  var selectli = $('.dropdown-select-ul li');

  // Then make them work
  selectdd.on('click',function() {
    $(this).parent('.dropdown-container').toggleClass('active');
  });

  // Hide it on mouseleave
  selectul.on('mouseleave',function() {
    $(this).parent('.dropdown-container').removeClass('active');
  });

  // Select the option
  selectli.on('click',function() {
    var _this = $(this);

    // Ensure clicking group labels does not cause change
    if (!_this.hasClass('optgroup')) {
      var parentul = _this.parent('ul');
      var thisdd = parentul.siblings('.dropdown-select');
      var lihtml = _this.html();
      var livalue = _this.attr('data-value');
      var originalselect = '#' + parentul.attr('data-role');

      // Close the dropdown
      parentul.parent('.dropdown-container').toggleClass('active');
      
      // Remove selected class from all list items
      _this.siblings('li').removeClass('selected');
      
      // Add .selected to clicked li
      _this.addClass('selected');
      
      // Set the value of the hidden input
      $(originalselect).val(livalue);
      
      // Change the dropdown text
      thisdd.children('span').html(lihtml);
    }
  });
}

var ready = function() {
  customSelect();
};

$(document).ready(ready);
