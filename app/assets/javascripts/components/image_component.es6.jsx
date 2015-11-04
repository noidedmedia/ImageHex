class ImageComponent extends React.Component{
  constructor(props){
    super(props);
    this.state = {
      useBigImage: false
    };
  }
  render(){
    var image;
    if(this.state.useBigImage){
      image = <img src={this.props.img.full_url} 
        onClick={this.toggleBigImage.bind(this)} />;
    }
    else{
      image = <img src={this.props.img.medium_thumbnail} 
        onClick={this.toggleBigImage.bind(this)} />;
    }
    return <div className="live-image">
      {image}
      {this.contentRatings()}
      {this.moreInfo()}
    </div>;
  }
  moreInfo(){
    if(this.state.hasMoreInfo){
      var tagGroups = this.state.imgInfo.tag_groups.map((group) => {

        return <li key={group.id}>
          <TagGroupComponent group={group} />
        </li>
      });
      var creators = this.state.imgInfo.creators.map((creator) => {
        return <li key={creator.id}>
          <UserComponent user={creator} />
        </li>;
      });
      return <div className="live-image-full-info">
        <div className="creators">
          <h2>Creators</h2>
          {creators}
        </div>
        <div className="tag-groups">
        Tag Groups:
        <ul>
          {tagGroups}
        </ul>
      </div>
    </div>
    }
    else{
      return <div onClick={this.fetchMoreInfo.bind(this)}>
        Get More Information
      </div>;
    }
  }
  fetchMoreInfo(){
    this.props.img.getFullData((img) => {
      this.setState({
        imgInfo: img,
        hasMoreInfo: true
      });
    });
  }
  toggleBigImage(event){
    console.log("Toggling big image");
    console.log(this);
    if(this.state.useBigImage){
      this.setState({
        useBigImage: false
      });
    }
    else{
      this.setState({
        useBigImage: true
      });
    }
  }
  contentRatings(){
    if(this.props.showContentRatings){
      return <ul className="live-image-content-ratings">
        <li className={this.props.img.nsfw_gore ? "" : "hidden"}>
          NSFW Gore
        </li>
        <li className={this.props.img.nfsw_nudity ? "" : "hidden"}>
          NSFW Nudity
        </li>
        <li className={this.props.img.nsfw_language ? "" : "hidden"}>
          NSFW Language
        </li>
        <li className={this.props.img.nsfw_sexuality ? "" : "hidden"}>
          NSFW Sexuality
        </li>
      </ul>
    }
    else{
      return <div />;
    }
  }
}
