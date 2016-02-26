/**
 * This component handles the entire chat, including all conversations.
 * It's kind of gross, mostly owing to how it constantly fetches all messages,
 * then manually associates them. 
 *
 * The data storage on this needs a rewrite, but I am fairly certain that I 
 * actually know how to do it. Kind of.
 */
class Chat extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      unread: props.initialUnread,
      conversationCollection: new ConversationCollection(props.conversations),
      hasFetchedConversations: false,
      lastFetchedAt: new Date(props.initialFetched),
      focusedIndex: 0
    };
    this.beginPolling();
  }

  render() {
    var index = this.state.focusedIndex;
    var activeConv = this.state.conversationCollection.withIndex(index);
    var active = <ConversationComponent
          conversation={activeConv}
          key={activeConv.id}
          currentUserId={this.props.currentUserId}
          fetchOlderMessages={this.fetchOlderMessages.bind(this, index)}
          createMessage={this.createMessage.bind(this, activeConv)}
        />;
    var convs = this.state.conversationCollection.map((conv, ind) => {
      
        return <ConversationSidebarComponent
          key={conv.id}
          conversation={conv}
          isActive={ind === index}
          currentUserId={this.props.currentUserId}
          focus={this.focusConversation.bind(this, ind)}
        />;
      
    }).filter(a => a);
    return <div className="chat-container">
      <div className="conversations-sidebar">
        {convs}
      </div>
      {active}
    </div>;
  }

  /**
   * Create a new message in a conversation
   */
  createMessage(conversation, body) {
    console.log("Creating message in chat component");
    conversation.createMessage(body, (message) => {
      this.setState({
        conversationCollection: this.state.conversationCollection,
        lastSentAt: new Date()
      });
    });
    this.fetchNewMessages();
  }

  fetchOlderMessages(index, callback) {
    var conv = this.state.conversationCollection.conversations[index];
    console.log(`Told to fetch older messages for ${conv.id}, doing so.`);
    conv.fetchOlderMessages((msg) => {
      console.log("Message fetch finished. Updating state.");
      callback();
      this.setState({
        conversationCollection: this.state.conversationCollection
      });
    });
  }

  unreadMessageCount() {
    if (this.state.unread) {
      return this.state.unread.length;
    }
    else if (this.state.conversationsCollection) {
      return this.state.conversationCollection.unreadMessageCount();
    }
    else {
      return "";
    }
  }

  fetchNewMessages() {
    console.log("Fetching messages in chat.");
    Message.createdSince(this.state.lastFetchedAt, (messages) => {
      var state = {
        lastFetchedAt: new Date(),
        conversationsCollection: this.state.conversationsCollection
      };
      if (messages) {
        console.log("Got new messages, updating last recieved at.");
        state.lastRecievedAt = new Date();
        this.state.conversationCollection.addMessages(messages);
      }
      this.setState(state);
    });
  }

  focusConversation(index) {
    this.setState({
      focusedIndex: index
    });
    var conv = this.state.conversationCollection.conversations[index];
    this.readConversation(conv);
  }
  // Start listening periodically for changes 
  beginPolling() {
    function poll() {
      this.fetchNewMessages();
      console.log(`Determining how long to poll.
                  Last sent: ${this.state.lastSentAt}
                  LastRecieved: ${this.state.lastRecievedAt}`);
                  if (this.state.lastSentAt &&
                      new Date() - this.state.lastSentAt < 10 * 1000) {
                    console.log("Sent within the last ten seconds.");
                  return window.setTimeout(poll.bind(this), 1000);
                  }
                  else if (this.state.lastRecievedAt && 
                           new Date() - this.state.lastRecievedAt < 10 * 100) {
                    console.log("Recieved in the last ten seconds.");
                  return window.setTimeout(poll.bind(this), 1.5 * 1000);
                  }
                  else {
                    console.log("Using default time.");
                    return window.setTimeout(poll.bind(this), 10 * 1000);
                  }
    }
    window.setTimeout(poll.bind(this), 10000);
  }

  readConversation(conv) {
    console.log("Marking all messages in conversation #",conv.id,"as read");
    conv.markRead(() => {
      this.setState({
        conversationsCollection: this.state.conversationsCollection
      });
    });
  }
}
