class SearchPage extends React.Component{
  constructor(props){
    super(props);
    console.log("Got props:",props);
    this.state = {
      tagGroups: this.findInitialGroups(),
      focusedGroup: 0
    };
  }

  findInitialGroups(){
    if(this.props.query && this.props.query.tag_groups){
      return this.props.query.tag_groups.map((g) => {
        return new EtherealTagGroup(g);
      });
    }
    else{
      return [new EtherealTagGroup()];
    }
  }

  render(){
    console.log("Focused group:",this.state.focusedGroup);
    let tags = this.state.tagGroups.map((group, index) => {
      console.log("Is group #",index," the foused group? ",index == this.state.focusedGroup);
      return <TagGroupEditor 
        key={index}
        group={group} 
        tags={group.tags}
        onTagRemove={this.removeTagFromGroup.bind(this, index)}
        onTagAdd={this.addTagToGroup.bind(this, index)}
        autofocus={index == this.state.focusedGroup}
        onSubmit={this.onSubmit.bind(this)}
      />;
    });
    return <div className="search">
      <h1>Search</h1>
      <li className="search-tag-groups">
        {tags}
      </li>
      <button onClick={this.addGroup.bind(this)}>Add a Group</button>
      <button onClick={this.onSubmit.bind(this)}>Submit</button>
    </div>
  }

  onSubmit(){
    var query = {};
    query.tag_groups = this.state.tagGroups.map((group) => {
      var tags = group.tags.map((tag) => {
        return {
          id: tag.id,
          display_name: tag.display_name
        };
      });
      return {
        tags: tags
      };
    });
    console.log("Query is", query);
    window.location.href = "/search?query=" + JSON.stringify(query);
  }
  addGroup(){
    this.setState({
      tagGrops: this.state.tagGroups.push(new EtherealTagGroup()),
      focusedGroup: this.state.tagGroups.size - 1
    })
  }
  removeTagFromGroup(groupIndex, tag){
    var newArray = this.state.tagGroups;
    newArray[groupIndex].removeTag(tag);
    this.setState({
      tagGroups: newArray,
      focusedGroup: groupIndex
    });
  }
  addTagToGroup(groupIndex, tag){
    var newArray = this.state.tagGroups;
    newArray[groupIndex].addTag(tag);
    this.setState({
      tagGroups: newArray,
      focusedGroup: groupIndex
    });
  }
}
