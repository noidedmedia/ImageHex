class TagGroupComponent extends React.Component{
  render(){
    var tags = this.props.group.tags.map((tag) => {
      return <TagComponent key={tag.id} tag={tag} />;
    });
    return <div>
      Tag Group:
      <ul>
        {tags}
      </ul>
    </div>;
  }
}