import ReactUJS from '../../react_ujs';
import React from 'react';
import SearchGroup from './search_group.es6.jsx';
import Turbolinks from 'turbolinks'
import $ from 'jquery';

class SearchPage extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      tagGroups: this.findInitialGroups(),
      focusedGroup: 0
    };
    this.groupKey = -1;
  }

  findInitialGroups() {
    if (this.props.groups) {
      let key = 0;
      return this.props.groups.map(group => {
        console.log("Group is",group);
        let tags = group.map(t => {
          return {
            id: t, 
            name: this.props.tags[t]
          };
        });
        console.log("Tags are",tags);
        return {
          key: key++,
          tags: tags
        };
      });
    }
    else {
      return [{key: 0}];
    }
  }

  render() {
    console.log("Focused group:",this.state.focusedGroup);
    let tags = this.state.tagGroups.map((group, index) => (
      <SearchGroup
        key={group.key}
        index={index}
        removeSelf={this.removeGroup.bind(this, index)}
        addTag={this.addGroupTag.bind(this, index)}
        removeTag={this.removeGroupTag.bind(this, index)}
        tags={group.tags} />
    ));
    return <div className="search">
      <form>
        <h1>Search</h1>
        <ul className="search-tag-groups">
          {tags}
        </ul>
        <div className="search-controls">
          <button
            type="button"
            onClick={this.addGroup.bind(this)}
            className="add-group-button">
            Add a Group
          </button>

          <button
            type="submit"
            className="submit-button"
            onClick={this.submit.bind(this)}>
            Search
          </button>
        </div>
      </form>
    </div>;
  }

  removeGroup(index) {
    var g = this.state.tagGroups.splice(index, 1);
    this.setState({
      tagGroups: this.state.tagGroups
    });
  }

  addGroup(event) {
    this.setState({
      tagGroups: [...this.state.tagGroups, {key: this.groupKey, tags: []}]
    });
    this.groupKey = this.groupKey - 1;
  }

  addGroupTag(index, tag) {
    let g = this.state.tagGroups[index].tags
    this.state.tagGroups[index].tags = [...g, tag];
    this.setState({
      tagGroups: this.state.tagGroups
    });
  }

  removeGroupTag(index, tag) {
    let g = this.state.tagGroups[index].tags
    this.state.tagGroups[index].tags = g.filter(t => t.id !== tag.id);
    this.setState({
      tagGroups: this.state.tagGroups
    });
  }

  submit(event) {
    event.preventDefault();
    let groups = this.state.tagGroups.map((g) => {
      return g.tags.map(t => t.id);
    });
    let params = {
      tag_groups: groups
    };
    Turbolinks.visit(`/search?${$.param(params)}`);
  }
}

ReactUJS.register("SearchPage", SearchPage);

export default SearchPage;
