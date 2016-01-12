class CommissionBackgroundForm extends React.Component{
  constructor(props){
    super(props);
    var initialRefs = [];
    if(props.background && props.background.references){
      initialRefs = props.background.references;
    }
    this.state = {
      refs: initialRefs,
      refKey: 0
    }
  }
  render(){
    var refs = this.state.refs.map((ref, index) => {
      var key = ref.id || ref.key;
      return <CommissionBackgroundForm.ReferenceField
        {...ref}
        remove={this.removeReference.bind(this, index)}
        index={index}
        key={key} />;
    });
    var button = <button onClick={this.addReference.bind(this)} type="button">
      Add a Reference Image
    </button>;
    if(this.state.refs.filter(r => ! r.removed).length > 9){
      console.log("Maximum refs in background reached");
      button = "";
    }
    var idField;
    if(this.props.background && this.props.background.id){
      idField = <input
        type="hidden"
        name="commission_offer[background_attributes][id]"
        value={this.props.background.id} />;
    }
    return <div>
      <button onClick={this.props.removeBackground}>
        Remove Background
      </button>
      {idField}
      <textarea name="commission_offer[background_attributes][description]">
      </textarea>
      {refs}
      {button}
    </div>
  }
  removeReference(index){
    this.state.refs[index].removed = true;
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

CommissionBackgroundForm.ReferenceField = (props) => {
  console.log("In background reference field, got props",props);
  var fieldName = `commission_offer[background_attributes]`;
  fieldName += `[references_attributes][${props.index}]`;
  if(props.removed){
    if(props.id){
      return <div>
        <input type="hidden"
          name={fieldName + "[id]"}
          value={props.id} />
        <input type="hidden"
          name={fieldName + "[_destroy]"}
          value="true" />
      </div>;
    }
    // No need for a delete attribute
    else{
      return <div></div>;
    }
  }
  //
  else if(props.id){
    return <div className="background-reference-input persisted">
      <img src={props.url} />
      <button onClick={props.remove} type="button">
        Remove Reference
      </button>
    </div>;
  }
  else{
    return <div className="background-reference-input">
      <input type="file"
        name={fieldName + "[file]"} />
      <button onClick={props.remove} type="button">
        Remove Reference
      </button>
    </div>
  }
};

CommissionBackgroundForm.BackgroundRemovalFields = (props) => {
  var fieldName = "commission_offer[background_attributes]";
  if(! props.background){
    return <div></div>;
  }
  return <div>
    <input type="hidden"
      name={fieldName + "[id]"}
      value={props.background.id} />
    <input type="hidden"
      name={fieldName + "[_destroy]"}
      value="true" />
  </div>;
}
