class ReferenceImageField extends React.Component {
  constructor(props){
    super(props);
    this.state = {};
  }
  render(){
    // Peristed 
    if(this.props.reference.id){
      return <div className="reference-image">
        <div class="reference-inner">
          <div className="reference-inner">
            <img src={this.props.reference.url}
              className="reference-image-thumbnail" />
          </div>
        </div>
        <button onClick={this.removeSelf.bind(this)}
          className="reference-remove-button">
          Remove
        </button>
      </div>;
    }
    if(this.state.fileURL) {
      return <div className="reference-image">
        <div className="reference-inner">
          <input
            type="file" 
            className="reference-image-file-field"
            onChange={this.addFile.bind(this)}/>
          <img src={this.state.fileURL}
            className="reference-image-thumbnail" />
        </div>
        <button onClick={this.removeSelf.bind(this)}
          className="reference-remove-button">
          Remove
        </button>
      </div>;
    }

    return <div className="reference-image">
      <div className="reference-inner dropzone">
        <div className="reference-drop-zone"
          ref="dropZone"
          onDragLeave={this.dragLeave.bind(this)}
          onDragOver={this.dragOver.bind(this)}
          onClick={this.openBrowser.bind(this)}>
          <input
            type="file" 
            className="reference-image-file-field"
            onChange={this.addFile.bind(this)}/>
          <h1>Drop a File</h1>
        </div>
      </div>
      <button onClick={this.removeSelf.bind(this)}
        className="reference-remove-button">
        Remove
      </button>
    </div>
  }

  addFile(event) {
    if(event.target.files && event.target.files[0]) {
      this.setState({
        fileURL: URL.createObjectURL(event.target.files[0])
      });
    }
  }

  dragLeave(event) {
    console.log("Drag leaving");
    this.refs.dropZone.classList.remove("active");
    event.preventDefault();
  }

  dragOver(event) {
    console.log(this.refs.dropZone.classList);
    this.refs.dropZone.classList.add("active");
    event.preventDefault();
    event.dataTransfer.dropEffect = "move";
    console.log("Draging something over");
  }

  openBrowser(event){
    console.log("Opening a file browser");
  }

  removeSelf(){
    this.props.remove();
  }
}
