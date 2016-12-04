import React from 'react';
import TagGroupEditor from './tag_group_editor.es6.jsx';

class TagGroupFieldsEditor extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      tags: props.initialTags || []
    };
  }

  render() {
    return <div className="tag-group-fields-editor">
      <TagGroupEditor
        tags={this.state.tags}
        onTagAdd={this.addTag.bind(this)}
        onTagRemove={this.removeTag.bind(this)}
        autofocus={false}
        allowTagCreation={this.props.allowTagCreation || false}
        hideSubmit={() => {}}
        showSubmit={() => {}} />
      {this.getTagInputs()}
    </div>
  }

  getTagInputs() {
    return this.state.tags.map((tag) => {
      return <input type="hidden"
        value={tag.id}
        name={this.props.fieldName + "[]"}
        key={tag.id} />;
    });
  }

  addTag(tag) {
    var { tags } = this.state;
    var found = tags.find((t) => (t.id === tag.id));
    if(! found) {
      this.setState({
        tags: [...tags, tag]
      });
    }
    // Otherwise do nothing
  }

  removeTag(tag) {
    this.setState({
      tags: this.state.tags.filter(t => t.id !== tag.id)
    });
  }
}

export default TagGroupFieldsEditor;
