class HeaderSearch extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      tagGroup: new EtherealTagGroup()
    };
  }
  render() {
    return <div id="header-search-react">
      <TagGroupEditor
        key={1}
        group={this.state.tagGroup}
        tags={this.state.tagGroup.tags}
        onTagRemove={this.removeTag.bind(this)}
        onTagAdd={this.addTag.bind(this)}
        isSearch={true}
        submit={this.submit.bind(this)}
      />
    </div>;
  }
  addTag(tag) {
    this.state.tagGroup.addTag(tag);
    this.setState({
      tagGroup: this.state.tagGroup
    });
  }
  removeTag(tag) {
    this.state.tagGroup.removeTag(tag);
    this.setState({
      tagGroup: this.state.tagGroup
    });
  }
  submit() {
    var query = {};
    var tags = this.state.tagGroup.tags.map((tag) => {
      return {
        id: tag.id,
        name: tag.name
      };
    });
    query.tag_groups = [{
      tags: tags
    }];
    window.location.href = "/search?" + $.param({query: query});
  }
}

document.addEventListener("page:change", function() {
  var hs = document.getElementById("header-search");
  console.log("header search container:", hs);
  ReactDOM.render(<HeaderSearch />,
               hs);
});
