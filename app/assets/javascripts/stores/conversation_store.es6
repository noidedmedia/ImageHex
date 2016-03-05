class ConversationStore{
  constructor(data) {
    this.data = data;
    this.data.store = this;
    this.listeners = [];
    window.setInterval(this.tick.bind(this), 1000);
    this.timeToUpdate = 5;
    this.lastRecvAt = Date.now();
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
      i++;
      while(i < messages.length && messages[i].user_id === user.id) {
        obj.messages.push(messages[i]);
        i++;
      }
      i--;
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
    m.sort((a, b) => {
      return new Date(b.created_at) - new Date(b.created_at);
    });
    return m;
  }

  sendChanges(){
    // Shitty version of object.assign basically
    var data = {
      id: this.data.id,
      name: this.data.name,
      messageGroups: this.chunkMessages(this.data.messages),
      users: this.data.users,
      updating: this.updating,
      timeToUpdate: this.timeToUpdate,
      store: this,
    };
    this.listeners.forEach((list) => list(data));
  }

  // Avoid doing the entire message-grouping thing every time we want to just
  // update the timer.
  //
  // This takes advantage of the fact that react's setState isn't just a 
  // replacement.
  sendTimingChanges() {
    var data = {
      updating: this.updating,
      timeToUpdate: this.timeToUpdate
    };
    this.listeners.forEach((l) => l(data));
  }

  tick(){
    console.log("Ticking...");
    if(this.updating){
      return;
    }
    this.timeToUpdate = this.timeToUpdate - 1;
    if(this.timeToUpdate <= 0) {
      this.updating = true;
      this.update();
    }
    this.sendTimingChanges();
  }

  update(){
    console.log("Getting stuff after",this.lastRecvAt);
    var url = `/conversations/${this.data.id}/messages.json`;
    // JS uses miliseconds
    var d = Math.floor(this.lastRecvAt / 1000);
    url += `?after=${d}`;
    var sentAt = Date.now();
    NM.getJSON(url, (messages) => {
      Array.prototype.push.apply(this.data.messages, messages);
      this.recalcUpdate(messages);
      var seen = {};
      // Get unique, just in case weird things happened
      this.data.messages = this.data.messages.filter((msg) => {
        return seen.hasOwnProperty(msg.id) ? false : (seen[msg.id] = true);
      });
      this.lastRecvAt = sentAt;
      this.sendChanges();
    });
  }
  recalcUpdate(ary) {
    this.updating = false;
    this.timeToUpdate = 30;
  }
}
