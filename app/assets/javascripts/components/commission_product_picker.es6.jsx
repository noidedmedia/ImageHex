class CommissionProductPicker extends React.Component{
  constructor(props){
    super(props);
    this.state = {
      page: 1,
      fetched: false,
    };
    console.log("In product picker, got props",props);
    this.fetchData(props);
  }
  render(){
    if(this.state.fetched){
      var products = this.state.products.map((p) => {
        return <CommissionProductDisplay
            product={p}
            clickTitle={this.onAdd.bind(this, p)}
            {...this.props} />;
      });
      return <ul className="commission-products-list">
        {products}
      </ul>;
    }
    else{ 
      return <div>
        <progress></progress>
      </div>;
    }
  }
  componentWillReceiveProps(nextProps){
    console.log("Commission product picker is receiving new props",nextProps);
    if((this.props.subjectsCount == nextProps.subjectsCount &&
        this.props.hasBackground == nextProps.hasBackgroud)){
      console.log("subjectsCount or hasBackground has not changed.");
      return;
    }
    this.setState({
      page: 1
    });
    this.fetchData(nextProps);
  }
  onAdd(product){
    this.props.onAdd(product);
  }
  // Get a new list products we can use
  fetchData(props){
    console.log("Fetching new data");
    CommissionProduct.withCriteria(props, this.state.page, (products) => {
      this.setState({
        fetched: true,
        products: products
      });
    });
  }
}
