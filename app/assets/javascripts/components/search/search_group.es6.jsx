import TagGroupEditor from '../tag_groups/tag_group_editor.es6.jsx';
import NM from '../../api/global.es6';

class SearchGroup extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      tags: props.initialTags || []
    };
  }

  render() {
    return <li className="search-page-tag-group">

      <TagGroupEditor
        autofocus={true}
        tags={this.state.tags}
        onTagAdd={this.addTag.bind(this)}
        onTagRemove={this.removeTag.bind(this)}
        isSearch={true} />
      {this.formFields}

      <a onClick={this.props.removeSelf}
        className="remove-button">
        Remove Group
      </a>
    </li>;
  }

  get formFields() {
    let groupIndex = this.props.index;
    const fieldName = (index, name) => (
      `query[tag_groups][${groupIndex}][tags][${index}][${name}]`
    );
    return this.state.tags.map((tag, index) => (
      <div key={tag.id}>
        <input
          name={fieldName(index, "name")}
          type="hidden"
          value={tag.name} />
        <input
          name={fieldName(index, "id")}
          type="hidden"
          value={tag.id} />
      </div>
    ));
  }

  addTag(tag) {
    if(this.state.tags.find(t => t.id === tag.id)) {
      // Tag already exists, do nothing
    }
    else {
      this.setState({
        tags: [...this.state.tags, tag]
      });
    }
  }

  removeTag(tag) {
    this.setState({
      tags: NM.reject(this.state.tags, (t) => t.id === tag.id)
    });
  }
}

export default SearchGroup;
