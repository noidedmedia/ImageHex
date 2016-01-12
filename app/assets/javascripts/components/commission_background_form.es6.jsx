class CommissionBackgroundForm extends React.Component{
  constructor(props){
    super(props);
    var initialRefs = props.background.references || [];
    this.state = {
      refs: initalRefs,
      refKey: 0
    }
  }
  render(){
    var refs = this.state.refs.map((ref, index) => {
      name = "commission_offer[backgrounds_attributes][0][references_attributes][" + index + "]";
      var key = ref.id || ref.key;
      return <div key={key}>
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
    this.state.refs.push({
      key: this.state.refKey
    });
    this.setState({
      refs: this.state.refs,
      refKey: this.state.refKey - 1
    });
  }
}
