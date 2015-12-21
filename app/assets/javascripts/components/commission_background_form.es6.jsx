class CommissionBackgroundForm extends React.Component{
  constructor(props){
    super(props);
    this.state = {
      refs: []
    }
  }
  render(){
    var refs = this.state.refs.map((ref, index) => {
      name = "commission_offer[backgrounds_attributes][0][references_attributes][" + index + "]";
      return <div key="index">
        <input type="file"
          name={name + "[file]"}
        />
        <button type="button" onClick={this.removeReference.bind(this, index)}>
          Remove
        </button>
      </div>;
    });
    var button = <button onClick={this.addReference.bind(this)} type="button">
      Add a Reference Image
    </button>;
    if(this.state.refs.length > 9){
      console.log("Maximum refs in background reached");
      button = "";
    }
    return <div>
      <textarea name="commission_offer[backgrounds_attributes][0][description]">
      </textarea>
      {refs}
      {button}
    </div>
  }
  removeReference(index){
    this.state.refs.splice(index, 1);
    this.setState({
      refs: this.state.refs
    });
  }
  addReference(){
    this.state.refs.push({});
    this.setState({
      refs: this.state.refs
    });
  }
}
