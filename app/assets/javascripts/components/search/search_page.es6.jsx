import SearchGroup from './search_group.es6.jsx';

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
    if (this.props.query && this.props.query.tag_groups) {
      return this.props.query.tag_groups.map((g, i) => {
        return {
          initialTags: g.tags,
          key: i
        }
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
        initialTags={group.initialTags} />
    ));
    return <div className="search">
      <form action="/search" method="GET">
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
            className="submit-button">
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
    console.log("Add group fires");
    this.setState({
      tagGroups: [...this.state.tagGroups, {key: this.groupKey}]
    });
    this.groupKey = this.groupKey - 1;
  }
}

window.SearchPage = SearchPage;
export default SearchPage;
