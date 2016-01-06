class ConversationComponent extends React.Component{
  constructor(props){
    super(props);
    this.state = {}
  }
  render(){
    var messages = this.props.conversation.messages.map((msg) => {
      return <MessageComponent key={msg.id}
        message={msg} />;
    });
    return <div className="conversation focused">
      {this.conversationTitle()}
      <MessageListComponent messages={this.props.conversation.messages}
        fetchOlderMessages={this.props.fetchOlderMessages}
        hasOlderMessages={this.hasOlderMessages.bind(this)} />
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
    console.log("Submitting a messsage with body:",this.state.inputValue);
  }

  hasOlderMessages(){
    return this.props.conversation.hasOlderMessages();
  }
  conversationTitle(){
    return this.props.conversation.users
      .filter((u) => u.id !== this.props.currentUserId)
      .map((u) => u.name)
      .join(", ");
  }
}
