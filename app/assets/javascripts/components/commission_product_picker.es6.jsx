class CommissionProductPicker extends React.Component{
  constructor(props){
    super(props);
    this.state = {
      page: 1,
      fetched: false,
    };
    console.log("In product picker, got props",props);
    this.fetchData();
  }
  render(){
    if(this.state.fetched){
      var products = this.state.products.map((p) => {
        return <div className="commission-product-possible"
          key={p.id} >
          <CommissionProductDisplay
            product={p}
            clickTitle={this.onAdd.bind(this, p)}
            {...this.props} />
        </div>
      });
      return <div>
        {products}
      </div>;
    }
    else{ 
      return <div>
        <progress></progress>
      </div>;
    }
  }
  componentWillReceiveProps(nextProps){
    if((this.props.subjectsCount == nextProps.subjectsCount &&
        this.props.hasBackground == nextProps.hasBackgroud)){
      return;
    }
    this.setState({
      page: 1
    });
    this.fetchData();
    
  }
  onAdd(product){
    this.props.onAdd(product);
  }
  // Get a new list products we can use
  fetchData(){
    CommissionProduct.withCriteria(this.props, this.state.page, (products) => {
      this.setState({
        fetched: true,
        products: products
      });
    });
  }
}
