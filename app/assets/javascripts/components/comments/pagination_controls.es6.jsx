import React from 'react';

function onMobile() {
  return window.innerWidth < 600;
}
function generateSpan(current, span, max) {
  if(onMobile() && ! span) {
    span = 2;
  }
  else if(! span) {
    span = 6;
  }
  var rng = Math.round(span / 2);
  var bottom = current - rng;
  if(bottom < 1){
    bottom = 1;
  }
  var top = current + rng;
  if(max && top > max) {
    top = max;
  }
  var ary = [];
  for(var i = bottom; i <= top; i++) {
    ary.push(i);
  }
  return ary;
}

function makePageItem(a){
  var currentPage = (a == this.current);
  var c = "pagination-button";
  if(currentPage) {
    c += " disabled";
  }
  return <li className={c}
    onClick={currentPage ? null : this.changeTo.bind(undefined, a)}
    key={a}>
    {a}
  </li>
}

function addPrevious(props, ary, buttons) {
  var firstButton = <li className="pagination-button first-page"
    onClick={props.changeTo.bind(undefined, 1)}>
    1
  </li>;
  if(ary[0] > 2) {
    if(ary[0] !== 3) {
      buttons.unshift(<li className="pagination-dots">...</li>);
    }
    buttons.unshift(makePageItem.call(props, 2));
  }
  if(ary[0] !== 1) {
    buttons.unshift(firstButton);
  }
  var prevString = "←";
  if(! onMobile()) {
    prevString += " Previous"
  }
  if(props.current !== 1) {
    buttons.unshift(<li className="pagination-button prev-page"
      onClick={props.changeTo.bind(undefined, props.current - 1)}>
      {prevString}
    </li>);
  }
  else {
    buttons.unshift(<li className="pagination-button prev-page disabled">
      {prevString}
    </li>);
  }
}

function addNext(props, ary, buttons) {
  var lastPage =  <li className="pagination-button last-page"
    onClick={props.changeTo.bind(undefined, props.totalPages)}>
    {props.totalPages}
  </li>;
  // if the last button is 2 or more pages before the final page
  if(ary[ary.length - 1] < props.totalPages - 1) {
    // If the last button is more than 2 pages before the final page
    if(ary[ary.length - 1] !== props.totalPages - 2) {
      // Add some dots
      buttons.push(<li className="pagination-dots">...</li>);
    }
    buttons.push(makePageItem.call(props, props.totalPages - 1));
  }
  var nextEnabled = false;
  if(ary[ary.length - 1] !== props.totalPages) {
    buttons.push(lastPage);
    nextEnabled = true;
  }
  var nextString = "";
  if(! onMobile()) {
    nextString += "Next ";
  }
  nextString += "→";
  if(props.current !== props.totalPages) {
    buttons.push(<li className="next-page pagination-button"
      onClick={props.changeTo.bind(undefined, props.current + 1)}>
      {nextString}
    </li>);
  }
  else {
    buttons.push(<li className="next-page disabled pagination-button">
      {nextString}
    </li>);
  }
}

const PaginationControls = (props) => {
  console.log("In pagination controls, got props",props);
  var ary = generateSpan(props.current, props.span, props.totalPages);
  var buttons = ary.map(makePageItem.bind(props));
  addPrevious(props, ary, buttons);
  addNext(props, ary, buttons);
  return <ul className="pagination-buttons-list">
    {buttons}
  </ul>;
};

export default PaginationControls;
