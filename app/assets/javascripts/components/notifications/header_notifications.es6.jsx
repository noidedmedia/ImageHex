import React from 'react';
import NM from '../../api/global.es6';
import ReactUJS from '../../react_ujs';
import NotificationList from './list.es6.jsx';

class HeaderNotifications extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      unread: props.unread,
      fetched: false,
      active: false
    };
  }

  render() {
    if(! this.state.fetched) {
      return <div className="header-notifications">
        <div className="notifications-unread-count">
            <a href="/notifications" onClick={this.fetchNotifications.bind(this)}>
              {this.state.unread}
            </a>
        </div>
      </div>;
    }
    var name = "notifications-dropdown";
    name = (this.state.active) ? name + " active" : name + " inactive";
    return <div className="header-notifications active">
      <div className="notifications-unread-count">
        <a href="#" onClick={this.deactivate.bind(this)}>
          {this.state.unread}
        </a>
      </div>
      <div className={name}>
        <NotificationList
          notifications={this.state.notifications} 
          markRead={this.markRead.bind(this)} /> 
      </div>
    </div>;
  }

  deactivate(event) {
    this.setState({
      active: false
    });
  }

  async markRead() {
    await NM.postJSON("/notifications/mark_all_read", {});
    var notes = await NM.getJSON("/notifications/");
    this.setState({
      notifications: notes,
      active: false
    });
  }

  async fetchNotifications(event) {
    event.preventDefault();
    var q = await NM.getJSON("/notifications.json");
    this.setState({
      notifications: q,
      fetched: true,
      active: true
    });
  }
}

ReactUJS.register("HeaderNotifications", HeaderNotifications);
export default HeaderNotifications;
