class ConversationComponent extends React.Component{
  constructor(props){
    super(props);
    this.state = {};
  }
  render(){
    var className= "conversation focused";
    if(this.props.conversation.hasUnreadMessages()){
      className = className + " has-unread";
    }
    return <div className={className}>
      <h2>{this.conversationTitle()}</h2>
      <MessageListComponent messages={this.props.conversation.messages}
        fetchOlderMessages={this.props.fetchOlderMessages}
        hasOlderMessages={this.hasOlderMessages.bind(this)} 
        currentUserId={this.props.currentUserId}
        />
      <textarea className="chat-input"
        value={this.state.inputValue}
        onChange={this.onChange.bind(this)}
        onKeyDown={this.keydown.bind(this)}></textarea>
    </div>;
  }

  onChange(event){
    console.log("Change event detected");
    this.setState({
      inputValue: event.target.value
    });
  }

  keydown(event){
    if(event.shiftKey){
      return;
    }
    if(event.keyCode === 13){
      this.submitMessage();
    }
  }

  submitMessage(){
    console.log("Submitting a new message with body:",this.state.inputValue);
    this.props.createMessage(this.state.inputValue);
    this.setState({
      inputValue: ""
    });
  }

  hasOlderMessages(){
    return this.props.conversation.hasOlderMessages();
  }

  conversationTitle(){
    var users = this.props.conversation.users
      .filter((u) => u.id !== this.props.currentUserId)
      .map((u) => u.name)
      .join(", ");
    return `Conversation with ${users}`;
  }
}
