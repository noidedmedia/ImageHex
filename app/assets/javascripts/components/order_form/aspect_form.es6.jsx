class AspectForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    return <div>
      I'm an aspect for option {this.props.option_id}
    </div>;
  }
}

export default AspectForm;
