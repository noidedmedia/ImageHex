class AspectForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    return <div className="aspect-form">
      <div className="description-container textarea-container">
        <label htmlFor={this.param("description")}>
          Description
        </label>
        <textarea name={this.param("description")}>
        </textarea>
      </div>
    </div>;
  }

  param(str) {
    return `order[aspects_attributes][${this.props.index}][${str}]`;
  }
}

export default AspectForm;
