class Conversation {
  constructor(obj) {
    this.messages = [];
    this.users = [];
    for (var prop in obj) {
      if (prop === "users" && Array.isArray(obj.users)) {
        obj.users.forEach((user) => {
          this.users.push(new User(user));
        });
      }
      else if (prop === "messages" && Array.isArray(obj.messages)) {
        obj.messages.forEach((msg) => {
          this.messages.push(msg);
        });
      }
      else {
        this[prop] = obj[prop];
      }
    }
  }

  hasOlderMessages() {
    if ("_hasOlder" in this) {
      return this._hasOlder;
    }
    return true;
  }

  // The oldest message we have is the last message in our array
  oldestMessage() {
    return this.messages[0];
  }

  unreadMessageCount() {
    if (this.messages === []) {
      return 0;
    }
    var init = 0;
    for (var i = this.messages.length - 1; i >= 0; i--) {
      if (this.messages[i].read) {
        return init;
      }
      init++;
    }
    return init;
  }

  hasUnreadMessages() {
    return this.unreadMessageCount() === 0;
  }

  markRead(callback) {
    console.log(`Conversation ${this.id} told to mark self as read.`);
    NM.postJSON(this.baseURL() + "/read", {}, () => {
      this.messages.forEach((msg) => msg.read = true);
      console.log(`Conversation ${this.id} successfully marked as read.`);
      callback(this);
    });
  }

  createMessage(body, callback, error) {
    var url = this.baseURL() + "/messages";
    console.log(`Conversation ${this.id} informed to create a message.`);
    console.log(`Message createion gives us a body string of ${body}`);
    var success = (msg) => {
      console.log(`New message (${msg.id}) created on #${this.id}.`);
      callback(this);
    };
    NM.postJSON(url, {message: {body: body}}, success, error);
  }

  baseURL() {
    return "/conversations/" + this.id;
  }

  fetchOlderMessages(callback) {
    if (this.hasOlderMessages()) {
      var url = this.baseURL() + "/messages";
      var msg;
      if (msg = this.oldestMessage()) {
        url = url + "?before=" + msg.created_at;
      }
      console.log(`Fetching older messages for conversation ${this.id}`);
      NM.getJSON(url, (data) => {
        if (data.length == 0) {
          this._hasOlder = false;
          callback(false);
        }
        else {
          var d = data.map((da) => new Message(da));
          this.addMessages(d);
          callback(this);
        }
      });
    }
    else {
      callback(false);
    }
  }
  static find(id, callback) {
    NM.getJSON("/conversations/" + id, (data) => {
      callback(new Conversation(data));
    });
  }
  addMessage(msg) {
    this.messages.push(msg);
    this.associateUser(msg);
    this.sortMessages();
    return this;
  }
  // Add messages lets you add many messages at once in a more efficient
  // way
  addMessages(messages) {
    messages.forEach((msg) => {
      this.messages.push(msg);
      this.associateUser(msg);
    });
    this.sortMessages();
    return this;
  }

  sortMessages() {
    this.messages.sort(function(a, b) {
      return new Date(a.created_at) - new Date(b.created_at);
    });
    // Remove duplicates
    this.messages = this.messages.filter((value, index, self) =>{
      for(var i = index + 1; i < self.length; i++){
        if(self[i].id === value.id) {
          console.log("Found a duplicate message, removing!");
          return false;
        }
      }
      return true;
    });
  }
  
  trim(num) {
    var ind = num | 5;
    this.messages = this.messages.slice(0 - ind);
  }
  
  associateUser(msg) {
    for (var i = 0; i < this.users.length; i++) {
      if (this.users[i].id == msg.user_id) {
        msg.user = this.users[i];
        return this;
      }
    }
  }
}
