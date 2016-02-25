/**
 * This component handles the entire chat, including all conversations.
 * It's loosely modeled after Facebook's chat.
 */
class Chat extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      unread: props.initialUnread,
      hasFetchedConversations: false,
      lastFetchedAt: props.initialFetched,
      focusedIndex: 0
    };

  }

  render() {
    /**
     * If chat is active we display it
     * Otherwise we just display a list of conversations
     */
    if (this.state.active) {
      if (! this.state.conversationCollection) {
        /**
         * Don't have conversations apparently, so display a progress bar while
         * we load them
         */
        return <div>
          <progress></progress>
        </div>;
      }
      var c = this.state.conversationCollection.map((conv, ind) => {
        /**
         * If this is the focused converation, we use this
         */
        if (ind === this.state.focusedIndex) {
          return <ConversationComponent
            conversation={conv}
            key={conv.id}
            currentUserId={this.props.currentUserId}
            fetchOlderMessages={this.fetchOlderMessages.bind(this, ind)}
            createMessage={this.createMessage.bind(this, conv)}
          />;
        } 
        else {
          return <UnfocusedConversationComponent
            key={conv.id}
            conversation={conv}
            currentUserId={this.props.currentUserId}
            focus={this.focusConversation.bind(this, ind)}
          />;
        }
      });
      return <div>
        {c}
      </div>;
    }
    /**
     * Display a stub when the conversation is not active
     */
    else {
      var unreadCount = this.unreadMessageCount();
      return <div onClick={this.activate.bind(this)}>
        Chat ({unreadCount} messages unread)
      </div>;
    }
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

  activate() {
    console.log("Chat linked is clicked, activating...");
    this.beginPolling();
    if (! this.state.conversationCollection) {
      ConversationCollection.getCurrent((conv) => {
        if (this.state.unread) {
          conv.addMessages(this.state.unread);
        }
        this.readConversation(conv.conversations[0]);
        this.setState({
          conversationCollection: conv,
          unread: []
        });
      });
    }
    var obj = {active: true};
    if (this.state.unread && this.state.conversationCollection) {
      obj[unread] = [];
      this.state.conversationCollection.addMessages(this.state.unread);
    }
    this.setState(obj);
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
