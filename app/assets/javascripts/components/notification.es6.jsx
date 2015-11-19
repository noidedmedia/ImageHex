class NotificationList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      notifications: props.notifications
    };
  }
  render() {
    var notifications = this.state.notifications.map((n) => {
      return <NotificationItem {...n} key={n.id} />;
    });
    return <div className={"notifications-container"}>
      <div className={"notifications-header"}>
        <h3>Notifications</h3>
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
      this.setState({
        notifications: []
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
    return <li className={"notifications-list-item"}>
      <a href={this.link()}>
        {this.message()}
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
    if (kind == "uploaded_image_commented_on") {
      return <div>
        {this.props.subject.user_name} commented on your image
      </div>;
    }
    if (kind == "comment_replied_to") {
      return <div>
        {this.props.subject.user_name} replied to your comment
      </div>;
    }
    if (kind == "mentioned") {
      return <div>
        {this.props.subject.user_name} mentioned you in a comment
      </div>;
    }
    else {
      return <div>
        Something in our javascript has gone horribly wrong.
      </div>;
    }
  }
}

document.addEventListener("page:change", function() {
  console.log("Notification works");
  var d = document.getElementsByClassName("notifications-unread-count")[0];
  if (d) {
    d.addEventListener("click", function(event){
      event.preventDefault();
      console.log("Clicked");
      NM.getJSON("/notifications/unread", (json) => {
        var d = document.getElementsByClassName("notifications-dropdown")[0];
        d.className = "notifications-dropdown active";
        ReactDOM.render(<NotificationList notifications={json} />,
            d);
      });
    });
  }
  else {
    console.log("We didn't find a notifications unread count. oops.");
  }

});
