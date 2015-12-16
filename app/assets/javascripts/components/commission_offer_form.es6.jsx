class CommissionOfferForm extends React.Component{
  constructor(props){
    super(props);
    this.state = {
      product: props.product,
      offer: props.offer
    };
  }
  render(){
    var subjects = this.state.offer.subjects.map((subj, index) => {
      return <li><CommissionSubject subj={subj} key={subj.id} /></li>;
    })
    return <div>
      <ul>
        {subjects}
      </ul>
      <button onClick={this.newSubject.bind(this)}>
        New Subject
      </button>
      <span className="offer-cost">
        Total cost is {Math.round(this.state.offer.getPrice() / 100)}
      </span>
    </div>;
  }
}

document.addEventListener("page:change", function(){
  console.log("Commission offer form listener fires");
  var d = document.getElementById("offer-form-react-container");
  if(d){
    var id = d.dataset.productId;
    CommissionProduct.find(id, (c) => {
      console.log("Found product", c);
      ReactDOM.render(<CommissionOfferForm product={c} offer={c.buildOffer()} />,
                      d);
    });
  }
});
