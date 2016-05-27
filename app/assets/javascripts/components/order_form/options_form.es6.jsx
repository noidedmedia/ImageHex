class OptionsForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    let o = this.props.options.map((opt, i) => {
      let info = this.optionContainedInfo(opt.id);
      return <OptionSection
        option={opt}
        add={this.props.addOrderOption}
        remove={this.props.removeOrderOption}
        info={info}
        key={i} />;
    });
    return <ul className="options">
      {o}
    </ul>
  }

  optionContainedInfo(option_id) {
    for(var i = 0; i < this.props.orderOptions.length; i++) {
      const oo = this.props.orderOptions[i];
      if(oo.listing_option_id === option_id) {
        return {
          contained: true,
          index: i
        };
      }
    }
    return {
      contained: false,
      index: null
    };
  }
}

const OptionSection = ({info, option, add, remove}) => {
  const descHTML = {__html: option.html_description};
  var checkbox;
  if(info.contained) {
    checkbox = <input
      type="checkbox"
      checked={true}
      onChange={remove.bind(null, info.index)} />;
  }
  else {
    checkbox = <input
      type="checkbox"
      checked={false}
      onChange={add.bind(null, option.id)} />;
  }
  return <li className="option-fields">
    {checkbox}
    <div>
      <h3>{option.name}</h3>
      <div className="description"
        dangerouslySetInnerHTML={descHTML} />
    </div>
  </li>;
};

export default OptionsForm;
