import NM from '../../api/global.es6';
import NotificationItem from './item.es6.jsx';

class NotificationList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      notifications: props.notifications,
    };
  }

  render() {
    var notifications;
    if (this.state.notifications.length > 0) {
      notifications = this.props.notifications.map((n) => {
        return <NotificationItem {...n} key={n.id} />;
      });
    } else {
      notifications = <div className="notifications-empty">
        No notifications yet!
      </div>;
    }
    return <div className={"notifications-container"}>
      <div className={"notifications-header"}>
        <h3><a href="/notifications">Notifications</a></h3>
        <a className={"mark-all-read"} onClick={this.props.markRead}>
          Mark all read
        </a>
      </div>
      <ul>
        {notifications}
      </ul>
    </div>;
  }
}


export default NotificationList;
