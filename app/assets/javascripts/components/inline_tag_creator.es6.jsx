class InlineTagCreator extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      name: props.tagName
    }
  }

  render() {
    if (this.state.performingCreate) {
      return <div className="inline-tag-creation">
        <p>
          <span>Name:</span>
          <input type="text"
            value={this.state.name}
            onChange={this.handleNameChange.bind(this)}
          />
        </p>
        <p>
          <span>Description:</span>
          <textarea
            value={this.state.description}
            onChange={this.handleDescriptionChange.bind(this)} />
        </p>
        <button onClick={this.submit.bind(this)}>
          Submit
        </button>
      </div>;
    } else {
      return <div className="tag-creation inactive">
        Could not find any tags with that name. 
        <span onClick={this.startCreation.bind(this)}>
          Create one?
        </span>
      </div>;
    }
  }

  handleNameChange(e) {
    this.setState({
      name: e.target.value
    });
  }

  handleDescriptionChange(e) {
    this.setState({
      description: e.target.value
    });
  }

  startCreation() {
    this.props.hideSubmit();
    this.setState({
      performingCreate: true
    });
  }

  componentWillReceiveProps(props) {
    if (props.tagName) {
      this.setState({
        name: props.tagName
      });
    }
  }

  submit() {
    if (! this.state.hasSubmitted) {
      var cb = (tag) => {
        console.log("Callback called in inline tag group creator");
        this.props.onAdd(tag);
      };
      Tag.create({
        display_name: this.state.name,
        description: this.state.description
      }, cb);
      this.setState({
        hasSubmitted: true
      });
    }
  }
}
