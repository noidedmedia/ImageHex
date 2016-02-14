class ReferenceImageField extends React.Component {
  constructor(props){
    super(props);
    this.state = {};
  }
  render(){
    // Peristed 
    if(this.props.reference.id){
      return <div className="reference-image">
        <div className="reference-inner">
          <img src={this.props.reference.url}
            className="reference-image-thumbnail" />
        </div>
        <button onClick={this.removeSelf.bind(this)}>
          Remove
        </button>
      </div>;
    }
    if(this.state.fileURL) {
      return <div className="reference-image">
        <div className="reference-inner">
          <img src={this.state.fileURL}
            className="reference-image-thumbnail" />
        </div>
        <button onClick={this.removeSelf.bind(this)}>
          Remove
        </button>
      </div>;
    }
    return <div className="reference-image">
      <div className="reference-drop-zone"
        onDrop={this.dropFile.bind(this)}
        ref="dropZone"
        onDragLeave={this.dragLeave.bind(this)}
        onDragOver={this.dragOver.bind(this)}
        onClick={this.openBrowser.bind(this)}>
        <h1>Drop a File</h1>
      </div>
      <button onClick={this.removeSelf.bind(this)}>
        Remove
      </button>
    </div>
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

  dropFile(event) {
    console.log("Dropped a file in a drop zone");
    console.log(event.dataTransfer.files);
    event.preventDefault();

    return false;
  }

  openBrowser(event){
    console.log("Opening a file browser");
  }

  removeSelf(){
    this.props.remove();
  }
}
