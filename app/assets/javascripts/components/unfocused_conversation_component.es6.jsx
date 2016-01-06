class UnfocusedConversationComponent extends React.Component{
  constructor(props){
    super(props);
    this.state = {};
  }
  render(){
    return <div className="conversation unfocused"
      onClick={this.props.focus}>
      Conversation with {this.userNameList()}
    </div>;
  }
  userNameList(){
    var users = this.props.conversation.users
    return users.filter((u) => u.id !== this.props.currentUserId)
      .map((u) => u.name)
      .join(", ");
  }
}
