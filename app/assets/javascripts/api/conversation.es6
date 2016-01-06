class Conversation{
  constructor(obj){
    this.messages = [];
    this.users = [];
    for(var prop in obj){
      if(prop === "users" && Array.isArray(obj.users)){
        obj.users.forEach((user) => {
          this.users.push(new User(user));
        });
      }
      else if(prop === "messages" && Array.isArray(obj.messages)){
        obj.messages.forEach((msg) => {
          this.messages.push(msg);
        });
      }
      else{
        this[prop] = obj[prop];
      }
    }
  }
  hasOlderMessages(){
    if("_hasOlder" in this){
      return this._hasMore
    }
    return true;
  }
  // The oldest message we have is the last message in our array
  oldestMessage(){
    return this.messages[0];
  }

  createMessage(body, callback, error){
    var url = this.baseURL() + "/messages";
    var success = (msg) => {
      this.addMessage(new Message(msg));
      callback(this);
    };
    NM.postJSON(url, {message: {body: body}}, success, error);
  }
  
  baseURL(){
    return "/conversations/" + this.id;
  }

  fetchOlderMessages(callback){
    if(this.hasOlderMessages()){
      var url = this.baseURL() + "/messages";
      url = url + "?before=" + this.oldestMessage().created_at;
      console.log("Fetching older messages with URL",baseURL)
      NM.getJSON(url, (data) => {
        if(data.length == 0){
          this._hasOlder = false;
          callback(false);
        }
        else{
          var d = data.map((da) => new Message(da));
          this.addMessages(d);
          callback(this);
        }
      });
    }
    else{
      callback(false);
    }
  }
  static find(id, callback){
    NM.getJSON("/conversations/" + id, (data) => {
      callback(new Conversation(data));
    });
  }
  addMessage(msg){
    this.messages.push(msg);
    this.associateUser(msg);
    this.sortMessages();
    return this;
  }
  // Add messages lets you add many messages at once in a more efficient
  // way
  addMessages(messages){
    messages.forEach((msg) => {
      this.messages.push(msg);
      this.associateUser(msg);
    });
    this.sortMessages();
    return this;
  }

  sortMessages(){
    this.messages.sort(function(a, b){
      return new Date(a.created_at) - new Date(b.created_at);
    });
  }
  
  trim(num){
    var ind = num | 5
    this.messages = this.messages.slice(0 - ind);
  }
  
  associateUser(msg){
    for(var i = 0; i < this.users.length; i++){
      if(this.users[i].id == msg.user_id){
        msg.user = this.users[i];
        return this;
      }
    }
  }
}
