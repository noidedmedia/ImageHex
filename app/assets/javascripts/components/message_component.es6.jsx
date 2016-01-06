class MessageComponent extends React.Component{
  constructor(props){
    super(props);
    this.state = {};
  }
  render(){
    var msg = this.props.message
    return <li className="message-item">
      <div className="message-user-info">
        <a href={"/@" + msg.user.slug}>
          <img src={this.userAvatar()} 
            className="message-avatar" />
        </a>
      </div>
      <div className="message-body">
        {msg.body}
      </div>
    </li>;
  }
  userAvatar(){
    var avatar = this.props.message.user.avatar_path;
    return avatar;
  }
}
