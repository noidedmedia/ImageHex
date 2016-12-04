import React from 'react';
import Turbolinks from 'turbolinks';
import ReactUJS from '../../react_ujs';
import TagGroupEditor from '../tag_groups/tag_group_editor.es6.jsx';

class HeaderSearch extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      tags: []
    };
  }
  render() {
    return <div id="header-search-react">
      <TagGroupEditor
        key={1}
        tags={this.state.tags}
        onTagRemove={this.removeTag.bind(this)}
        onTagAdd={this.addTag.bind(this)}
        isSearch={true}
        isHeaderSearch={true}
        submit={this.submit.bind(this)}
      />
    </div>;
  }

  addTag(tag) {
    let tags = [...this.state.tags, tag];
    this.setState({
      tags: tags
    });
  }

  removeTag(tag) {
    let tags = this.state.tags.filter(t => t.id != tag.id);
    this.setState({
      tags: tags
    });
  }

  submit() {
    var query = {};
    var tags = this.state.tags.map((tag) => tag.id);
    query.tag_groups = [tags];
    Turbolinks.visit(`/search?${$.param(query)}`);
  }
}

ReactUJS.register("HeaderSearch", HeaderSearch);

export default HeaderSearch;
