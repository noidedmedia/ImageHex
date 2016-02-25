class ConversationCollection {
  constructor(array) {
    this.conversations = array.map((conversation) => {
      return new Conversation(conversation);
    });
    this.conversations.sort((a, b) =>{
      return a.id - b.id;
    });
  }
  // Remove all but the latest n messages in all conversations
  // if n is undefined, it will use the default(5);
  trim(n) {
    n = n || 5;
    this.conversations.forEach((conv) => conv.trim(n));
  }

  unreadMessageCount() {
    return this.conversations.reduce((a, b) => {
      return a + b.unreadMessageCount();
    }, 0);
  }
  map(func) {
    return this.conversations.map(func);
  }

  static getCurrent(callback) {
    NM.getJSON("/conversations", (data) => {
      callback(new ConversationCollection(data));
    });
  }
  // Get all unread messages and associate them with the proper conversation.
  // Call `callback` with `this` when finished.
  getUnread(callback) {
    NM.getJSON("/messages/unread", (messages) => {
      addMessages(messages);
      callback(this);
    });
  }
  // Given a list of messages for the conversations in this 
  // ConversationCollection, this method will add those messages to their
  // proper conversation. Note that any messages for conversations not
  // in this collection will be discarded.
  addMessages(messages) {
    // Associate messages into conversation ids
    var tmp = {};
    for (var i = 0; i < messages.length; i++) {
      var message = messages[i];
      if (tmp.hasOwnProperty(message.conversation_id)) {
        tmp[message.conversation_id].push(message);
      }
      else {
        tmp[message.conversation_id] = [message];
      }
    }
    for (var key in tmp) {
      var conv = this.conversationWithId(key);
      if (conv) {
        // Add messages to conversation objects
        conv.addMessages(tmp[key]);
      }
    }
  }
  conversationWithId(id) {
    for (var i = 0; i < this.conversations.length; i++) {
      if (this.conversations[i].id == id) {
        return this.conversations[i];
      }
    }
  }

  withIndex(index) {
    return this.conversations[index];
  }

}
