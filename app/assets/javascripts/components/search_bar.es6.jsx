class SearchBar extends React.Component{
  constructor(props){
    super(props);
    this.state = {
      tagGroups: [new EtherealTagGroup()],
      focusedGroup: 0
    };
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
      />;
    });
    return <div className="search">
      <h1>Search</h1>
      <li class="search-tag-groups">
        {tags}
      </li>
      <button onClick={this.addGroup.bind(this)}>Add a Group</button>
    </div>
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
