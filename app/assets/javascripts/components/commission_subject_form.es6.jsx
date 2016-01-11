class CommissionSubjectForm extends React.Component {
  constructor(props){
    super(props);
    var initialReferences = props.subj.references || [];
    this.state = {
      references: initialReferences,
      currentRefKey: 0
    };
    console.log("Creating a subject field for subject", props.subj);
  }
  render(){
    var refs = this.state.references.map((ref, index) => {
      var id = ref.id ? ref.id : ref.key;
      var b = this.baseFieldName() + "[references_attributes][" + index + "]";
      if(ref.removed){
        return <CommissionSubjectForm.RemovedReferenceFields
          key={id}
          baseFieldName={b}
          reference={ref}
        />;
      }
      return <SubjectReferenceField
        baseFieldName={b}
        reference={ref}
        index={index}
        key={id}
        remove={this.removeReference.bind(this, index)} />;
    });
    var refButton = <button onClick={this.addReference.bind(this)}
        type="button">
        Add a Reference Image
      </button>;
    if(refs.filter(r => ! r.deleted).length > 4){
      refButton = undefined;
    }
    return <div className="commission-subject-form-fields">
      <div>
        {this.idField()}
        Description
        <textarea name={this.descriptionFieldName()}
          type="text"
          defaultValue={this.defaultDescription()} />
        <input type="hidden"
          name={this.baseFieldName() + "[id]"}
          value={this.props.subj.id} />
        <SubjectTagSelector
          initialTags = {this.props.subj.tags ? this.props.subj.tags : []}
          baseFieldName={this.baseFieldName()} />
      </div>
      <ul className="subject-references-form">
        {refs}
      </ul>
      {refButton}
      <br/>
      <button onClick={this.removeSelf.bind(this)} type="button">
        Remove
      </button>
    </div>
  }
  idField(){
    if(this.props.subj.id){
      return <input name="id"
        type="hidden"
        value={this.props.subj.id}
      />;
    }
    return "";
  }
  addReference(event){
    event.preventDefault();
    var ref = this.state.references;
    ref.push({
      key: this.state.currentRefKey
    });
    this.setState({
      references: ref,
      currentRefKey: this.state.currentRefKey - 1
    });
  }

  removeReference(index){
    this.state.references[index].removed = true;
    this.setState({
      references: this.state.references
    });
  }

  removeSelf(event){
    console.log("removeSelf fires with event",event);
    event.preventDefault();
    this.props.remove();
  }
  defaultDescription(){
    console.log("In commission subject form, found props:",this.props);
    return this.props.subj.description || "";
  }
  descriptionFieldName(){
    return this.baseFieldName() + "[description]";
  }

  baseFieldName(){
    return "commission_offer[subjects_attributes][" + this.props.index + "]";
  }
}

CommissionSubjectForm.RemovedReferenceFields = (props) => {
  console.log("Removed reference field gets props:",props);
  if(! props.reference.id){
    return "";
  }
  return <div>
    <input name={props.baseFieldName + "[id]"}
      type="hidden"
      value={props.reference.id} />
    <input name={props.baseFieldName + "[_destroy]"}
      type="hidden"
      value="true" />
  </div>;
};

// Stateless component that shows removed subjects
CommissionSubjectForm.RemovedSubjectFields = (props) => {
  // Not actually persisted, just ignore it
  if(! props.subj.id){
    return "";
  }
  var baseName = `commission_offer[subjects_attributes][${props.index}]`;
  // Return fields to remove this subject
  return <div className="removed-subject-fields-container">
    <input
      name={baseName + "[id]"}
      type="hidden"
      value={props.subj.id} />
    <input name={baseName + "[_destroy]"}
      value="true"
      type="hidden" />
  </div>;
}

class SubjectTagSelector extends React.Component {
  constructor(props){
    console.log("Subject tag selector gets props:",props);
    super(props);
    this.state = {
      group: new TagGroup({
        tags: props.initialTags
      }),
      tags: props.tags
    };
  }
  render(){
    var tagInputs = this.state.group.tags.map((tag) => {
      return <input type="hidden"
        name={this.props.baseFieldName + "[tag_ids][]"}
        value={tag.id}
        key={tag.id} />
    });
    return <div>
      {tagInputs}
      <TagGroupEditor
        group={this.state.group}
        tags={this.state.group.tags}
        onTagRemove={this.removeTag.bind(this)}
        onTagAdd={this.addTag.bind(this)}
        submit={this.ignoreSubmit.bind(this)} />
    </div>
  }
  addTag(tag){
    this.state.group.addTag(tag);
    this.setState({
      group: this.state.group
    });
  }
  removeTag(tag){
    this.state.group.removeTag(tag);
    this.setState({
      group: this.state.group
    });
  }
  ignoreSubmit(event){
    console.log("Ignoring submit event",event);
    event.preventDefault();
  }
}

class SubjectReferenceField extends React.Component{
  constructor(props){
    super(props);
    console.log("Subject reference field gets props:",props);
  }
  render(){
    if(this.props.reference.id){
      return <div className="subject-reference-item persisted">
        <img src={this.props.reference.url} />
        <button type="button"
          onClick={this.removeSelf.bind(this)}>
          Remove
        </button>
      </div>;
    }
    else{
      return <div className="subject-reference-item">
        <input type="file"
          name={this.fileFieldName()}
        />
        <button type="button"
          onClick={this.removeSelf.bind(this)}>
          Remove Reference
        </button>
      </div>;
    }
  }
  fileFieldName(){
    return this.props.baseFieldName + "[file]"
  }
  removeSelf(){
    this.props.remove();
  }
}

