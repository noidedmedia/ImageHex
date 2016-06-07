class OptionsForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    let contained = this.getObtainedOptions();
    let o = this.props.options.map((opt, i) => {
      return <OptionSection
        option={opt}
        add={this.props.addOption}
        remove={this.props.removeOption}
        contained={contained[opt.id]}
        key={i} />;
    });
    let fields = this.props.optionIds.map((id) => {
      return <input
        type="hidden"
        name="order[option_ids][]"
        value={id} />;
    });
    return <div className="options-section">
      <h3>Options</h3>
      {fields}
      <ul className="option-fields-list">
        {o}
      </ul>
    </div>;
  }

  getObtainedOptions() {
    var dict = {};
    this.props.options.forEach((o) => {
      dict[o.id] = this.props.optionIds.indexOf(o.id) != -1;
    });
    return dict;
  }
}

const OptionSection = ({contained, option, add, remove}) => {
  const descHTML = {__html: option.html_description};
  var checkbox;
  if(contained) {
    checkbox = <input
      type="checkbox"
      checked={true}
      onChange={remove.bind(null, option.id)} />;
  }
  else {
    checkbox = <input
      type="checkbox"
      checked={false}
      onChange={add.bind(null, option.id)} />;
  }
  return <li className="option-fields">
    <div className="option-fields-header">
      <div>
        {checkbox}
      </div>
      <h3>{option.name}</h3>
    </div>
    <div className="description markdown-description"
      dangerouslySetInnerHTML={descHTML} />
  </li>;
};

export default OptionsForm;
