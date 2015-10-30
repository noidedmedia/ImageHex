class TagGroup extends React.Component {
  constructor(props){
    super(props);
    this.state = {};
  }
  render () {
    return <div className="tag_group">
      {this.props.tags.map(tag => {
        return <Tag {...tag} onRemove={this.props.onRemoveTag} />;
      })}
    </div>;
  }
}

