class ImageCollectionComponent extends React.Component{
  constructor(props){
    super(props);
    this.state = {
      loaded: false
    };
    console.log(this.props);
    this.doLoad();
  }
  render(){
    if(! this.state.loaded){
      return <progress></progress>;
    }
    else{
      console.log("Got images",this.state.images);
      var images = this.state.images.map((img) => {
        return <ImageComponent img={img} key={img.id} />;
      });
      return <div id="live-images">
        <button onClick={this.refresh.bind(this)}>Refresh</button>
        {images}
      </div>;
    }
  }
  refresh(){
    this.props.collection.getPageImages( (imgs) => {
      this.setState({
        loaded: true,
        images: imgs
      });
    });
  }
  doLoad(){
    console.log("Getting images from collection",this.props.collection);
    this.props.collection.getPageImages( (imgs) => {
      this.setState({
        loaded: true,
        collection: this.props.collection,
        images: imgs
      });
    });
  }
}
