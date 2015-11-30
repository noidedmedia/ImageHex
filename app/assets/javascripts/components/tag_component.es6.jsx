class TagComponent extends React.Component {
  constructor() {
    super();
    this.state = {
      moreInfo: false
    };
  }
  render() {
    if (this.state.moreInfo) {
      return <li className="image-tag-with-info">
        <div className="tag-name">
          {this.state.tag.display_name}
        </div>
        <div className="tag-descriptiaon">
          {this.state.tag.description}
        </div>
      </li>;
    } else {
      return <li className="image-tag" onClick={this.fetchInfo.bind(this)}>
        <div className="tag-name">
          {this.props.tag.display_name}
        </div>
      </li>
    }
  }
  fetchInfo() {
    this.props.tag.getFullData((tag) => {
      this.setState({
        moreInfo: true,
        tag: tag
      });
    });
  }
}
