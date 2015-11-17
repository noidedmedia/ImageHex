class CollectionAdder extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      collections: props.collections
    };
  }

  render() {
    var c = this.state.collections.map((c) => {
      return <CollectionAdderItem 
        collection={c}
        key={c.id}
        image_id={this.props.image_id} />;
    });
    return <ul id={"image-collection-list"}>
      {c}
    </ul>;
  }
}

class CollectionAdderItem extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      collection: props.collection
    };
  }

  render() {
    if (this.state.collection.contains_image) {
      return <li className={"collection-add-list-item contains-image"} onClick={this.removeImage.bind(this)}>
        <div className={"icon icon-close"}></div>
        <p>{this.state.collection.name}</p>
      </li>;
    }
    else {
      return <li className={"collection-add-list-item"} onClick={this.addImage.bind(this)}>
        <div className={"icon icon-add"}></div>
        <p>{this.state.collection.name}</p>
      </li>;
    }
  }

  addImage() {
    if (! this.state.performingAction) {
      this.state.collection.addImageWithId(this.props.image_id, (c) => {
        var c = this.state.collection
        c.contains_image = true
        this.setState({
          collection: c,
          performingAction: false
        });
      });
      this.setState({
        performingAction: true
      });
    }
  }

  removeImage() {
    if (! this.state.performingAction) {
      this.state.collection.removeImageWithId(this.props.image_id, (c) => {
        var collection = this.state.collection
        collection.contains_image = false
        this.setState({
          collection: collection,
          performingAction: false
        });
      });
      this.setState({
        performingAction: true
      });
    }
  }
}

document.addEventListener("page:change", function(e) {
  var d = document.getElementById("img-action-collection");
  console.log("event handler fires");
  if (d) {
    d.addEventListener("click", function(e) {
      console.log("Clicked!");
      console.log(this.dataset);
      Collection.inspectForImage(this.dataset.imageId, (c) => {
        var filtered = c.filter((q) => {
          if (q.type == "Creation" || q.type == "Favorite") {
            return false;
          } else {
            return true;
          }
        });
        ReactDOM.render(<CollectionAdder collections={filtered}
          image_id={this.dataset.imageId} />, document.getElementById("img-action-collection-tooltip"));
      });
    });
  }
});
