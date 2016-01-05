class MessageComponent extends React.Component{
  constructor(props){
    super(props);
    this.state = {};
    console.log("Making a message component with message",props.message);
  }
  render(){
    var msg = this.props.message
    return <li className="message-item">
      <img src={this.userAvatar()} />
      <p className="message-user-name">
        <a href={"/@" + msg.user.slug}>
          {msg.user.name}
        </a>
      </p>
      <div className="message-body">
        {msg.body}
      </div>
    </li>;
  }
  userAvatar(){
    var avatar = this.props.message.user.avatar_path;
    console.log("Got user avatar",avatar,"in message #",this.props.message.id);
    return avatar;
  }
}
