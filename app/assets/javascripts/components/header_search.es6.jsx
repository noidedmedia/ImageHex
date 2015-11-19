class HeaderSearch extends React.Component {
  constructor(props){
    super(props);
    this.state = {
      tagGroup: new EtherealTagGroup()
    };
  }
  render(){
    return <div>
      <TagGroupEditor
        key={1}
        group={this.state.tagGroup}
        onTagRemove={this.removeTag.bind(this)}
        onTagAdd={this.addTag.bind(this)}
        autofocus={true}
        onSubmit={this.submit.bind(this)}
      />
    </div>;
  }
  addtag(tag){
    this.state.tagGroup.add(tag)
    this.setState({
      tagGroup: this.state.tagGroup
    });
  }
  removeTag(tag){
    this.state.tagGroup.removeTag(tag);
    this.setState({
      tagGroup: this.state.tagGroup
    });
  }
  submit(){
    var query = {};
    var tags = this.state.tagGroup.tags.map((tag) => {
      return {
        id: tag.id,
        display_name: tag.display_name
      }
    });
    query.tag_groups = [{
      tags: tags
    }];
    window.location.href = "/search?query=" + JSON.stringify(query);
  }
}

document.addEventListener('page:load', function(){
  console.log("Header Search Event Fires");

});
