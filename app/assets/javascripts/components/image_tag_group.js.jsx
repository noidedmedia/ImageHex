class ImageTagGroup extends React.Component{
  constructor(props){
    super(props);
    if(this.props.isNew){
      var group = new EtherealTagGroup();
      this.state = {group: group}
    }
    else{
      this.state = {group: this.props.group};
    }
  }
  render(){
    return <div>
      <TagGroupEditor
        key={0}
        tags={this.state.group.tags}
        group={this.state.group}
        onTagAdd={this.addTag.bind(this)}
        onTagRemove={this.removeTag.bind(this)}
        autofocus={true}
        onSubmit={this.submit.bind(this)}
      />
      <button onClick={this.submit.bind(this)}>
        Submit
      </button>
  </div>;
  }
  addTag(tag){
    var group = this.state.group;
    group.addTag(tag);
    this.setState({group: group});
  }
  removeTag(tag){
    var group = this.state.group;
    group.removeTag(tag);
    this.setState({group: group});
  }
  submit(){
    if(this.state.group.id){
      var url = "/images/" + this.props.group.image_id + "/tag_groups/";
      url += this.state.group.id;
      delete this.state.group["image"];
      console.log("putting to url", url)
      var tag_ids = this.state.group.tags.map((t) => t.id);
      var data = {
        tag_group: {
          tag_ids: tag_ids
        }
      };
      NM.putJSON(url, data, function(){
        console.log("Woo, we did it, yay");
      });
    }
    // new tag group
    // case isn't handled yet...
    else{

    }
  }
}

document.addEventListener("DOMContentLoaded", function(){
  var elements = document.getElementsByClassName("edit-generic-tag-group");
  for(var element of elements){
    element.addEventListener("click", function(){
      Image.find(this.dataset.image_id, (img) => {
        console.log("Found an image");
        var group = img.groupWithId(this.dataset.group_id);
        ReactDOM.render(<ImageTagGroup group={group} />,
                        this.parentElement);
      });
    }.bind(element));
  }
});
