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
        key={id}
        value={id} />;
    });
    return <div className="show-listing-options-section order-options-section">
      <h2 className="padded-dark-header">
        Options
      </h2>
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
  var price;
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
  if(option.price > 0) {
    price = <strong>${(option.price / 100).toFixed(2)}</strong>
  }
  else {
    price = <strong>Free</strong>
  }
  return <li className="options-item order-options-item">
    <div className="order-options-checkmark">
      {checkbox}
    </div>
    <div className="order-options-body">
      <div className="options-header">
        <h3>{option.name}</h3>
        {price}
      </div>
      <div className="description markdown-description"
        dangerouslySetInnerHTML={descHTML} />
    </div>
  </li>;
};

export default OptionsForm;
