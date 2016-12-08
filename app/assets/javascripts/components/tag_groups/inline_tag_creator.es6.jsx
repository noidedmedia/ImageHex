import React from 'react';
import Tag from '../../api/tag.es6';

class InlineTagCreator extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      name: props.initialTagName
    };
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
        <span onClick={this.startCreation.bind(this)}>
          Create a tag?
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
    if (props.initialTagName.length > this.state.name.length) {
      this.setState({
        name: props.initialTagName
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
        name: this.state.name,
        description: this.state.description
      }, cb);
      this.setState({
        hasSubmitted: true
      });
    }
  }
}

InlineTagCreator.propTypes = {
  // Tell the parent form to hide the submit button.
  // See TagGroupEditor for details.
  hideSubmit: React.PropTypes.func,
  // Call this function with the newly-created tag after we finish creating
  // it.
  onAdd: React.PropTypes.func,
  // The initial value of this tag's name. Basically, if the user types
  // a part of a tag name and decides to make a new tag with that name,
  // we want that name to be in the form already. 
  initialTagname: React.PropTypes.string
};

export default InlineTagCreator;
