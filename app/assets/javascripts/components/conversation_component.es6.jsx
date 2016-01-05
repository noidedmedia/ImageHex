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
    return <div>
      Conversation
      <ul className="conversation-message-list">
        {messages}
      </ul>
    </div>;
  }
}
