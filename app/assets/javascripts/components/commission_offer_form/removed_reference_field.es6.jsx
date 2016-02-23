class RemovedReferenceField extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    if( this.props.reference.id ) {
      return <div class="reference-removed-fields">
        <input name={this.props.baseFieldName + "[id]"}
          type="hidden"
          value={this.props.reference.id} />
        <input name={this.props.baseFieldName + "[_destroy]"}
          type="hidden"
          value="true" />
      </div>;
    }
    return <div>
    </div>;
  }

}
