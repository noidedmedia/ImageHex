class ConversationStore{
  constructor(data) {
    this.data = data;
    this.data.store = this;
    this.listeners = [];
  }

  addListener(func){
    this.listeners.push(func);
    this.sendChanges();
  }

  chunkMessages(m) {
    var messages = this.sortMessages(m);
    var arr = [];
    for(var i = 0; i < messages.length; i++) {
      var user = this.userById(messages[i].user_id);
      var obj = {
        user: user,
        messages: [messages[i]]
      };
      while(i < messages.length && messages[i].user_id === user.id) {
        obj.messages.push(messages[i]);
        i++;
      }
      arr.push(obj);
    }
    return arr;
  }

  userById(id) {
    for(var i = 0; i < this.data.users.length; i++) {
      if(this.data.users[i].id === id){
        return this.data.users[i];
      }
    }
    return {};
  }
  sortMessages(m) {
    return m.sort((a, b) => {
      return new Date(b.created_at) - new Date(b.created_at);
    });
  }

  sendChanges(){
    var data = {
      id: this.data.id,
      name: this.data.name,
      messageGroups: this.chunkMessages(this.data.messages),
      users: this.data.users
    };
    this.listeners.forEach((list) => list(data));
  }
}
