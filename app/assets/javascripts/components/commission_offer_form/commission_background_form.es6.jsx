/**
 * Form for the background field
 */
class CommissionBackgroundForm extends React.Component{
  constructor(props){
    super(props);
    var initialRefs = [];
    if(props.background && props.background.references){
      initialRefs = props.background.references;
    }
    this.state = {
      refs: initialRefs, // reference images
      refKey: 0 // Lets use set the `key` on the ref component
    }
  }
  render(){
    // Create a list of reference images to use
    var refs = this.state.refs.map((ref, index) => {
      var fname = "commission_offer[background_attributes]";
      fname += `[references_attributes][${index}]`
      // Use the id if this is an existing reference (that we're editing),
      // or the set key otherwise
      var key = ref.id || ref.key;
      if(ref.removed) {
        return <RemovedReferenceField
          baseFieldName={fname}
          reference={ref} />
      }
      else {
        return <ReferenceImageField
          baseFieldName={fname}
          reference={ref}
          remove={this.removeReference.bind(this, index)}
          index={index}
          key={key} />;
      }
    });
    // Button to add another reference image
    var refButton = <button 
      onClick={this.addReference.bind(this)} 
      type="button">
      Add a Reference Image
    </button>;
    // We only allow 9 reference images, so remove the button if we have more
    if(this.state.refs.filter(r => ! r.removed).length > 9){
      console.log("Maximum refs in background reached");
      refButton = <span></span>;
    }
    var idField;
    if(this.props.background && this.props.background.id){
      // IF we're editing stuff, we gotta pass in the ID to rails so it
      // doesn't create an entirely new background record
      idField = <input
        type="hidden"
        name="commission_offer[background_attributes][id]"
        value={this.props.background.id} />;
    }
    return <div className="offer-fields-section background-fields">
      {idField}
      <div className="field-container">
        <label className="label">
          Description
        </label> 
        <textarea 
          className="input"
          name="commission_offer[background_attributes][description]">
        </textarea>
      </div>
      {refs}
      <div className="offer-action-buttons">
        {refButton}
        <button onClick={this.props.removeBackground}>
          Remove Background
        </button>
      </div>
    </div>
  }
  /**
   * Callback to remove a reference
   * Actually just sets the `removed` property to `true`, since
   * we gotta tell rails that we got rid of it
   */
  removeReference(index){
    console.log("Removing a reference image from a bacground");
    this.state.refs[index].removed = true;
    this.setState({
      refs: this.state.refs
    });
  }
  /**
   * Add a new reference
   * We do some weird stuff with keys here to insure each one has a unique
   * key - basically, we use *negative* keys, so they can't clash with the `id`
   * of a already-persisted reference
   */
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

/**
 * Stateless component that just renders a reference
 * Will show the input field and such. if it's removed, just render
 * invisible form fields to indicate that to Rails
 */
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
