import OptionFields from './option_fields.es6.jsx';

class OptionSection extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      options: props.options,
      deletedOptions: []
    };
  }

  render() {
    var options = this.state.options.map((o, i) => {
      return <li id={i}>
        <OptionFields
          option={o}
          index={i}
          quoteOnly={this.props.quoteOnly} />
      </li>;
    });

    return <div>
      <ul>
        {options}
      </ul>
      <button type="button"
        onClick={this.addOption.bind(this)}>
        Add an Option
      </button>
    </div>;
  }

  addOption() {
    var n = [...this.state.options, {}];
    this.setState({
      options: n
    });
  }
}

export default OptionSection;
