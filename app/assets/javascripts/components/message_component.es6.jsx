class MessageComponent extends React.Component{
  constructor(props){
    super(props);
    this.state = {};
  }
  render(){
    var msg = this.props.message;
    return <li className={this.containerClassName()}>
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

  containerClassName(){
    var t = "message-item";
    if (this.sentBySelf()){
      t = t + " sent-by-self";
    }
    return t;
  }

  sentBySelf(){
    return this.props.message.user.id == this.props.currentUserId;
  }

  userAvatar(){
    var avatar = this.props.message.user.avatar_path;
    return avatar;
  }
}
