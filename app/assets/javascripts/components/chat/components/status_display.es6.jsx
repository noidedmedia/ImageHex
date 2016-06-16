import { activate, deactivate } from '../actions.es6';

export default class StatusDisplay extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    var className = "status-display";
    var click = () => {};
    var msg;
    if(this.props.online) {
      className += " online";
      msg = "Online";
    }
    else {
      className += " offline ";
      msg = "Offline";
    }
    if(this.props.active) {
      className += " active";
    }
    else {
      className += " inactive"
      click = this.activate.bind(this);
    }
    return <div class={className}
      onClick={click}>
        {msg}
      </div>;
  }

  activate() {
    this.context.dispatch(activate());
  }
}

StatusDisplay.contextTypes = {
  store: React.PropTypes.object,
  dispatch: React.PropTypes.func
};


