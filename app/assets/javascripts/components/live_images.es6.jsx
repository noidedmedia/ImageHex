class LiveImages extends React.Component{
  constructor(){
    super();
    this.state = {loaded: false};
    this.doLoad();
  }
  render(){
    if(! this.state.loaded){
      return <progress></progress>;
    }
    else{
      var images = this.state.images.map((img) => {
        return <LiveImage img={img} key={img.id} />;
      });
      return <div id="live-images">
        <button onClick={this.refresh.bind(this)}>Refresh</button>
        {images}
      </div>;
    }
  }
  refresh(){
    this.state.collection.getPageImages( (imgs) => {
      this.setState({
        loaded: true,
        images: img
      });
    });
  }
  doLoad(){
    var collection = Image.allImages();
    collection.getPageImages( (imgs) => {
      this.setState({
        loaded: true,
        collection: collection,
        images: imgs
      });
    });
  }
}

class LiveImage extends React.Component{
  constructor(){
    super();
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
          <LiveTagGroup group={group} />
        </li>;
      });
      return <div className="live-image-full-info">
        Tag Groups:
        <ul>
          {tagGroups}
        </ul>
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
}

class LiveTagGroup extends React.Component{
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
