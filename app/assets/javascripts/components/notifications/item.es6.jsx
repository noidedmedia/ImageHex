import Message from './message.es6.jsx';

class NotificationItem extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      read: this.props.read
    };
  }
  render() {
    var className = "notifications-list-item";
    if (this.state.read) {
      className += " read";
    } else {
      className += " unread";
    }
    var handler = this.state.read ? function() {} : this.readSelf.bind(this);
    return <li className={className} onClick={handler}>
      <a href={this.link()}>
        {this.message()}
        {this.timeStamp()}
      </a>
    </li>;
  }

  async readSelf() {
    var r = await NM.postJSON("/notifications/" + this.props.id + "/read", {});
    this.setState({
      read: true
    });
  }

  visitLink() {
    Turbolinks.visit(this.link());
  }

  link() {
    if (this.props.subject.type == "comment") {
      if (this.props.subject.commentable_type == "Image") {
        var url = "/images/" + this.props.subject.commentable_id;
        url += "#comment-" + this.props.id;
        return url;
      }
    }
    else if (this.props.subject.type == "user") {
      return "/users/" + this.props.subject.id;
    }
    else if (this.props.subject.type == "order") {
      let { listing_id, order_id } = this.props.subject;
      return `/listings/${listing_id}/orders/${order_id}`;
    }
  }
  message() {
    let kind = this.props.kind;
    let fun = Message[kind];
    var msg;
    if(typeof fun === 'undefined') {
      msg = "Something in our javascript has gone horribly wrong";
    }
    else {
      msg = fun(this.props.subject);
    }
    return <p className="notification-message">
      {msg}
    </p>;
  }

  timeStamp() {
    return <p className="notification-time-ago">
      {this.props.time_ago_in_words} ago
      </p>;
  }
}

export default NotificationItem;
