import NM from '../../api/global.es6';
import NotificationItem from './item.es6.jsx';

class NotificationList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      notifications: props.notifications
    };
  }

  render() {
    var notifications;
    if (this.state.notifications.length > 0) {
      notifications = this.state.notifications.map((n) => {
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
        <a className={"mark-all-read"} onClick={this.markRead.bind(this)}>
          Mark all read
        </a>
      </div>
      <ul>
        {notifications}
      </ul>
    </div>;
  }
  async markRead() {
    await NM.postJSON("/notifications/mark_all_read", {});
    var notes = await NM.getJSON("/notifications/");
    $(".header-notifications").removeClass("unread").removeClass("active");
    $(".notifications-dropdown").removeClass("active");
    $(".notifications-unread-count > a").html("0");
    this.setState({
      notifications: notes
    });
  }
}

document.addEventListener("page:change", function() {
  var d = document.getElementsByClassName("notifications-unread-count")[0];
  if (d) {
    d.addEventListener("click", function(event) {
      event.preventDefault();
      document.querySelector(".header-notifications").classList.toggle("active");
      NM.getJSON("/notifications/", (json) => {
        document.querySelector(".notifications-dropdown").classList.toggle("active");
        ReactDOM.render(<NotificationList notifications={json} />,
            document.querySelector(".notifications-dropdown"));
      });
    });
  }
});
