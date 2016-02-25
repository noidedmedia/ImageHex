/**
 * This component displays a single conversation. It is rendered inside of a
 * larger chat component.
 */
class ConversationComponent extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }
  render() {
    var className= "conversation-active";
    if (this.props.conversation.hasUnreadMessages()) {
      className = className + " has-unread";
    }
    return <div className={className}>
      <h2 className="conversation-header">{this.conversationTitle()}</h2>
      {/* Use another component to manage messages */}
      <MessageListComponent messages={this.props.conversation.messages}
        fetchOlderMessages={this.props.fetchOlderMessages}
        hasOlderMessages={this.hasOlderMessages.bind(this)} 
        currentUserId={this.props.currentUserId}
        />
        <textarea className="chat-input"
          ref="input"
          onKeyDown={this.keydown.bind(this)}></textarea>
    </div>;
  }

  keydown(event) {
    if (event.shiftKey) {
      return;
    }
    if (event.keyCode === 13) {
      this.submitMessage();
      event.preventDefault();
    }
  }

  submitMessage() {
    console.log("Submitting a new message with body:",this.state.inputValue);
    this.props.createMessage(this.refs.input.value);
    this.refs.input.value = "";
  }

  hasOlderMessages() {
    return this.props.conversation.hasOlderMessages();
  }

  conversationTitle() {
    var users = this.props.conversation.users
      .filter((u) => u.id !== this.props.currentUserId)
      .map((u) => u.name)
      .join(", ");
    return `Conversation with ${users}`;
  }
}
