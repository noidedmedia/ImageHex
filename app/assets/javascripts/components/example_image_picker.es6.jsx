class ExampleImagePicker extends React.Component{
  constructor(props){
    super(props);
    this.state = {
      selectedImages: props.initialSelected || []
    };
  }
  render(){
    var inputs = this.state.selectedImages.map((img, index) => {
      var name = "commission_product[example_image_ids][]";
      return <input type="hidden"
        name={name}
        value={img.id}
        key={img.id} />;
    });
    return <div>
      {inputs}
      <ImagePickerView
        selectedImages={this.state.selectedImages}
        imageListDelegate={this.props.creationsCollection}
        addImage={this.addImage.bind(this)}
        removeImage={this.removeImage.bind(this)}
      />
    </div>;
  }
  addImage(img){
    this.state.selectedImages.push(img);
    this.setState({
      selectedImages: this.state.selectedImages
    });
  }
  removeImage(img){
    var index;
    for (let i = 0; i < this.state.selectedImages.length; i++){
      if (this.state.selectedImages[i].id == img.id){
        index = i;
        break;
      }
    }
    this.state.selectedImages.splice(index, 1);
    this.setState({
      selectedImages: this.state.selectedImages
    });
  }
}
