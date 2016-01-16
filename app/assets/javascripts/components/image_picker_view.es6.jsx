class ImagePickerView extends React.Component{
  constructor(props){
    super(props);
    this.state = {
      images: [],
      fetchingImages: true
    };
    this.fetchImages();
  }

  render(){
    var images = this.state.images.map((img) => {
      if(this.imageIsSelected(img)){
        return <ImagePickerView.SelectedImageItem
          deselect={this.removeImage.bind(this, img)}
          image={img} />;
      }
      else{
        return <ImagePickerView.NonselectedImageItem
          select={this.addImage.bind(this, img)}
          image={img} />;
      }
    });
    var progressBar;
    if(this.state.fetchingImages){
      progressBar = <progress></progress>;
    }
    return <div>
      {progressBar}
      <ul className="image-picker-images-list">
        {images}
      </ul>
      <button type="button"
        onClick={this.getPreviousPage.bind(this)}
        disabled={! this.props.imageListDelegate.hasPreviousPage()}>
        ←
      </button>
      <button type="button"
        onClick={this.getNextPage.bind(this)}
        disabled={! this.props.imageListDelegate.hasNextPage()}>
        →
      </button>
    </div>;
  }

  imageIsSelected(img){
    var imgs = this.props.selectedImages;
    for(var i = 0; i < imgs.length; i++){
      if(imgs[i].id == img.id){
        return true;
      }
    }
    return false;
  }

  addImage(img){
    console.log("Attempting to add image",img);
    this.props.addImage(img);
  }

  removeImage(img){
    console.log("Attemping to remove image", img);
    this.props.removeImage(img);
  }

  fetchImages(){
    this.props.imageListDelegate.getPageImages((imgs) => {
      this.setState({
        images: imgs,
        fetchingImages: false
      });
    });
    this.setState({
      fetchingImages: true
    });
  }

  getNextPage(){
    this.props.imageListDelegate.nextPage();
    this.fetchImages();
  }

  getPreviousPage(){
    this.props.imageListDelegate.previousPage();
    this.fetchImages();
  }
}

ImagePickerView.SelectedImageItem = (props) => {
  return <li className="image-picker-item selected"
    onClick={props.deselect}>
    <img src={props.image.medium_thumbnail} />
  </li>;
};

ImagePickerView.NonselectedImageItem = (props) => {
  return <li className="image-picker-item"
    onClick={props.select}>
    <img src={props.image.medium_thumbnail} />
  </li>;
};
