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
  markRead() {
    console.log("Trying to read notifications");
    NM.postJSON("/notifications/mark_all_read", {}, () => {
      NM.getJSON("/notifications/", (n) => {
        console.log("Got new notifications");
        document.querySelector(".header-notifications").classList.remove("unread", "active");
        document.querySelector(".notifications-dropdown").classList.remove("active");
        document.querySelector(".notifications-unread-count > a").innerHTML = "0";
        this.setState({
          notifications: n
        });
      });
    });
  }
}

class NotificationItem extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }
  render() {
    className = "notifications-list-item";
    if (this.props.read) {
      className += " read";
    } else {
      className += " unread";
    }
    return <li className={className}>
      <a href={this.link()}>
        {this.message()}
        {this.timeStamp()}
      </a>
    </li>
  }
  link() {
    if (this.props.subject.type == "comment") {
      if (this.props.subject.commentable_type == "Image") {
        return "/images/" + this.props.subject.commentable_id;
      }
    }
  }
  message() {
    var kind = this.props["kind"];
    console.log("Props:",this.props);
    var username = this.props.subject.user_name;
    if (kind == "uploaded_image_commented_on") {
      return <p className="notification-message">
        {username} commented on your image
      </p>;
    }
    if (kind == "comment_replied_to") {
      return <p className="notification-message">
        {username} replied to your comment
      </p>;
    }
    if (kind == "mentioned") {
      return <p className="notification-message">
        {username} mentioned you in a comment
      </p>;
    }
    else {
      return <p className="notification-message">
        Something in our javascript has gone horribly wrong.
      </p>;
    }
  }
  timeStamp() {
    return <p className="notification-time-ago">3 minutes ago</p>
  }
}

document.addEventListener("page:change", function() {
  console.log("Notification works");
  var d = document.getElementsByClassName("notifications-unread-count")[0];
  if (d) {
    d.addEventListener("click", function(event) {
      event.preventDefault();
      document.querySelector(".header-notifications").classList.toggle("active");
      console.log("Clicked");
      NM.getJSON("/notifications/", (json) => {
        document.querySelector(".notifications-dropdown").classList.toggle("active");
        ReactDOM.render(<NotificationList notifications={json} />,
            document.querySelector(".notifications-dropdown"));
      });
    });
  }
  else {
    console.log("We didn't find a notifications unread count. oops.");
  }

});
