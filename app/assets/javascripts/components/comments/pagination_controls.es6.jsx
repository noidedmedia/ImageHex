function generateSpan(current, span, max) {
  var rng = Math.round((span || 6) / 2);
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
    c += " current-page";
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
  if(ary[ary.length - 1] !== props.totalPages) {
    buttons.push(lastPage);
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
