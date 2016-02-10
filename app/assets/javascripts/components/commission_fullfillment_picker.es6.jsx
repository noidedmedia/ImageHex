class CommissionFullfillmentPicker extends React.Component{
  constructor(props){
    super(props);
    this.state = {
      selectedImage: null
    };
  }

  render(){
    var input;
    var list = [];
    if (this.state.selectedImage){
      list = [this.state.selectedImage];
      input = <input type="hidden"
        name="image_id"
        value={this.state.selectedImage.id} />;

    }
    return <div>
      {input}
      <ImagePickerView
        selectedImages={list}
        imageListDelegate={this.props.creationsCollection}
        addImage={this.addImage.bind(this)}
        removeImage={this.removeImage.bind(this)} />
    </div>;
  }
  addImage(img){
    this.setState({
      selectedImage: img
    });
  }
  removeImage(img){
    if (this.state.selectedImage && this.state.selectedImage.id == img.id){
      this.setState({
        selectedImage: null
      });
    }
  }
}
