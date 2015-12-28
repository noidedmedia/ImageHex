class ImagePicker extends React.Component{
  constructor(props){
    super(props);
    this.state = {
      images: null,
      selectedImages: []
    };
    this.fetchImages();
  }
  render(){
    if(this.state.images){
      var imgs = this.state.images.map((img) => {
        return <ImagePickerItem key={img.id} 
          image={img}
          selected={this.isSelected(img)}
          select={this.selectImage.bind(this)}
          deselect={this.deselectImage.bind(this)} />
      });
      return <div>
        <ul className="image-picker-list">
          {imgs}
        </ul>
        {this.fileFields()}
      </div>
    }
    else{
      return <progress></progress>;
    }
  }

  fileFields(){
    var name;
    if(this.state.multi){
      name = this.props.fieldName + "[]";
    }
    else{
      name = this.props.fieldName
    }
    return this.state.selectedImages.map((img) => {
      return <input type="hidden"
        name={name}
        value={img.id}
        key={img.id} />
    });
  }

  selectImage(img){
    console.log("Selecting image:",img);
    if(this.props.multi){
      this.state.selectImages.push(img);
      this.setState({
        selectedImages: this.state.selectedImages
      });
    }
    else{
      this.setState({
        selectedImages: [img]
      });
    }
  }
  deselectImage(img){
    for(var i in this.state.selectImages){
      if(this.state.selectedImages[i].id === img.id){
        this.state.selectedImages.splice(i, 1);
      }
    }
    this.setState({
      selectedImages: this.state.selectedImages
    });
  }

  isSelected(img){
    return this.state.selectedImages.some((i) => {
      return img.id === i.id;
    }); 
  }
  fetchImages(){
    this.props.collection.getPageImages((images) => {
      console.log("Got images:",images);
      this.setState({
        images: images
      });
    });
  }
}

class ImagePickerItem extends React.Component{
  constructor(props){
    super(props);
    this.state = {};
  }
  render(){
    var sel = this.props.selected ? "selected" : "";
    return <li className={"image-picker-item " + sel}>
      <img
        src={this.props.image.medium_thumbnail} 
        onClick={this.click.bind(this)} />
    </li>;
  }
  click(event){
    if(this.props.selected){
      this.props.deselect(this.props.image);
    }
    else{
      this.props.select(this.props.image);
    }
  }
}
document.addEventListener("page:change", function(){
  var container = document.getElementById("fullfill-picker-container");
  if(container){
    var id = container.dataset.userId;
    User.find(id, (user) => {
      var creations = user.creations;
      ReactDOM.render(<ImagePicker collection={creations} 
        multi={false}
        fieldName={"image_id"}
      />,
      container);
    });
  }
});
