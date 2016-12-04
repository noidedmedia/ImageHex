import React from 'react';
import TagGroupEditor from '../tag_groups/tag_group_editor.es6.jsx';
import NM from '../../api/global.es6';

class SearchGroup extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return <li className="search-page-tag-group">
      <TagGroupEditor
        autofocus={true}
        tags={this.props.tags}
        onTagAdd={this.props.addTag}
        onTagRemove={this.props.removeTag}
        isSearch={true} />

      <a onClick={this.props.removeSelf}
        className="remove-button">
        Remove Group
      </a>
    </li>;
  }
}

export default SearchGroup;
