import React from 'react';
import NM from '../../api/global.es6';
import ReactUJS from '../../react_ujs';
import NotificationList from './list.es6.jsx';
import Cable from './cable';
import Message from './message';

function notify(note) {
  function makeNote() {
    let mfunc = Message[note.kind] || (( ) => "JS Error");
    let msg = mfunc(note.subject)
    var notification = new Notification(msg,
      {
        icon: `/favicon-64.png`,
        badge: `/favicon-64.png`
      });
  }
  if(! ("Notification" in window) ) {
    return;
  }
  else if(window.Notification.permission === "granted") {
    makeNote();
  }
  else if(window.Notification.permission !== "denied") {
    window.Notification.requestPermission((perm) => {
      if(perm === "granted") {
        makeNote();
      }
    });
  }
}

class HeaderNotifications extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      unread: props.unread,
      fetched: false,
      active: false,
      notifications: []
    };
    console.log(Cable);
    Cable.listener = (notification) => {
      notify(notification);
      this.addNotification(notification);
    };
  }

  get notificationClass() {
    let beta = "header-notifications";
    if(this.state.unread > 0) {
      beta += " has-unread";
    }
    return beta;
  }

  render() {
    if(! this.state.fetched) {
      return <div className={this.notificationClass}>
        <div className="notifications-unread-count">
            <a onClick={this.fetchNotifications.bind(this)}>
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

  addNotification(note) {
    let notes = [...this.state.notifications, note];
    notes.sort((a, b) => new Date(a.created_at) - new Date(b.created_at));
    this.setState({
      notifications: notes,
      unread: this.state.unread + 1,
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
