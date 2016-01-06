class UnfocusedConversationComponent extends React.Component{
  constructor(props){
    super(props);
    this.state = {};
  }
  render(){
    var className = "conversation unfocused";
    if(this.props.conversation.hasUnreadMessages()){
      className = className + " has-unread";
    }
    return <div className={className}
      onClick={this.props.focus}>
      {this.title()}
    </div>;
  }
  userNameList(){
    var users = this.props.conversation.users
    return users.filter((u) => u.id !== this.props.currentUserId)
      .map((u) => u.name)
      .join(", ");
  }
  title(){
    var base = this.userNameList();
    if(this.props.conversation.hasUnreadMessages()){
      var count = this.props.conversation.unreadMessagesCount();
      base = base + "(" + count + " unread)";
    }
    return base;
  }
}
