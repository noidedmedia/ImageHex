import AspectForm from './aspect_form.es6.jsx';

const AddButton = ({aspects, max_allowed, free_count, price, addAspect}) => {
  if(aspects.length >= max_allowed) {
    return <div></div>;
  }

  if(aspects.length < free_count) {
    return <button type="button"
      onClick={addAspect}>
      Add Another (Free)
    </button>;
  }

  return <button type="button"
    onClick={addAspect}>
    Add Another (${price / 100})
  </button>;
};

class OptionForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    var aspects = this.props.aspects.map((a) => {
      return <AspectForm
        {...a} />
    });

    return <div>
      <div className="option-info">
        <h1>{this.props.name}</h1>
      </div>

      <div className="option-aspects">
        {aspects}
      </div>
      <AddButton {...this.props} />
    </div>;
  }
}

export default OptionForm;
