import TagGroup from '../../api/tag_group.es6';
import TagGroupEditor from '../tag_groups/tag_group_editor.es6.jsx';

/**
 * Models one `subject` which has been added to a commission
 */
class CommissionSubjectForm extends React.Component {
  constructor(props){
    super(props);
    var initialReferences = props.subj.references || [];
    this.state = {
      references: initialReferences,
      currentRefKey: 0
    };
  }

  render(){
    // Get a list of reference images
    var refs = this.state.references.map((ref, index) => {
      var id = ref.id ? ref.id : ref.key; // see backgrounds to clarify
      var b = this.baseFieldName() + "[references_attributes][" + index + "]";
      if(ref.removed){
        return <RemovedReferenceField
          key={id}
          baseFieldName={b}
          reference={ref}
        />;
      }
      return <ReferenceImageField
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
    // Disallow creation of a reference image if we have too many
    if(refs.filter(r => ! r.deleted).length > 4){
      refButton = undefined;
    }
    return <div className="offer-fields-section subject-fields">
      <div>
        {/* Grab the form field to model this subject's id */}
        {/* will obviously be nonexistant if we aren't persisted */}
        {this.idField()}
        <div className="field-container">
          <label className="label">
            Description
          </label>
          <textarea name={this.descriptionFieldName()}
            type="text"
            className="input"
            defaultValue={this.defaultDescription()} />
        </div>
        
        {/* Add tags to commissions, wow */}
        <SubjectTagSelector
          initialTags = {this.props.subj.tags ? this.props.subj.tags : []}
          baseFieldName={this.baseFieldName()} />
      </div>
      {/* list of reference images */}
      <ul className="subject-references-form">
        {refs}
      </ul>
      {/* Button to add another reference */}
      <div className="offer-action-buttons">
        {refButton}
        {/* Button to get rid of this subject */}
        <button onClick={this.removeSelf.bind(this)} type="button">
          Remove Subject
        </button>
      </div>
    </div>
  }
  /**
   * Returns form field to indicate to rails that we're modifying an
   * existing subject, if we actually are 
   */
  idField(){
    if(this.props.subj.id){
      return <input name={this.baseFieldName() + "[id]"}
        type="hidden"
        value={this.props.subj.id}
      />;
    }
    return "";
  }

  /**
   * Add a new reference image
   */
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



// Stateless component that shows removed subjects
CommissionSubjectForm.RemovedSubjectFields = (props) => {
  // Not actually persisted, just ignore it
  if(! props.subj.id){
    console.log("Not returning anything because we have no id");
    return <span></span>;
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
    return <div className="subject-tag-field"> 
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

export default CommissionSubjectForm;
