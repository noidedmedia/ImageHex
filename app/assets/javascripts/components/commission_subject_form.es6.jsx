class CommissionSubjectForm extends React.Component {
  constructor(props){
    super(props);
    this.state = {};
  }
  render(){
    return <div className="commission-subject-form-fields">
      <div>
        Description
        <input name={this.descriptionFieldName()}
          type="text"
          defaultValue={this.defaultDescription()} />
      </div>
      <button onClick={this.removeSelf.bind(this)}>
        Remove
      </button>
    </div>
  }
  removeSelf(event){
    event.preventDefault();
    this.props.remove();
  }
  descriptionFieldName(){
    return "";
  }
}
