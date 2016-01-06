class Chat extends React.Component{
  constructor(props){
    super(props);
    this.state = {
      unread: props.initialUnread,
      hasFetchedConversations: false,
      focusedIndex: 0
    }
  }
  render(){
    if(this.state.active){
      if(! this.state.conversationCollection){
        return <div>
          <progress></progress>
        </div>;
      }
      var c = this.state.conversationCollection.map((conv, ind) => {
        if(ind === this.state.focusedIndex){
          return <ConversationComponent
            conversation={conv}
            key={conv.id}
            currentUserId={this.props.currentUserId}
            fetchOlderMessages={this.fetchOlderMessages.bind(this, ind)}
            createMessage={this.createMessage.bind(this, conv)}
          />;
        } else {
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
    else{
      var unreadCount = this.unreadMessageCount();
      return <div onClick={this.activate.bind(this)}>
        Chat ({unreadCount} messages unread)
      </div>;
    }
  }
  createMessage(conversation, body){
    console.log("Creating message in chat component");
    conversation.createMessage(body, (message) => {
      this.setState({
        conversationCollection: this.state.conversationCollection
      });
    });
  }

  fetchOlderMessages(index, callback){
    console.log("Want to fetch messages with index", index);
    var conv = this.state.conversationCollection.conversations[index];
    console.log("Fetching older messages for conv", conv);
    conv.fetchOlderMessages((msg) => {
      console.log("Message fetch finished");
      callback();
      this.setState({
        conversationCollection: this.state.conversationCollection
      });
    });
  }

  unreadMessageCount(){
    if(this.state.unread){
      return this.state.unread.length;
    }
    else if(this.state.conversationsCollection){
      return this.state.conversationCollection.unreadMessageCount();
    }
    else{
      return "";
    }
  }

  focusConversation(index){
    this.setState({
      focusedIndex: index
    });
    this.readConversation(this.conversationCollection.conversations[index]);
  }

  activate(){
    console.log("Activating chat");
    if(! this.state.conversationCollection){
      ConversationCollection.getCurrent((conv) => {
        if(this.state.unread){
          conv.addMessages(this.state.unread);
        }
        console.log("Got current collection", conv);
        this.readConversation(conv.conversations[0]);
        this.setState({
          conversationCollection: conv,
          unread: []
        });
      });
    }
    var obj = {active: true}
    if(this.state.unread && this.state.conversationCollection){
      obj[unread] = [];
      this.state.conversationCollection.addMessages(this.state.unread);
    }
    this.setState(obj);
  }

  readConversation(conv){
    console.log("marking ", conv, "as read");
    conv.markRead(() => {
      this.setState({
        conversationsCollection: this.state.conversationsCollection
      });
    });
  }
}

document.addEventListener("page:change", function(){
  if(! USER_SIGNED_IN){
    return;
  }
  var elem = document.getElementById("chatbox");
  console.log("Got element",elem,"for chat");
  Message.unread((msg) => {
    ReactDOM.render(<Chat initialUnread={msg} 
                    currentUserId={USER_ID}/>,
                    elem);
  });
});
