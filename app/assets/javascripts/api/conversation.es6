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
  static find(id, callback){
    NM.getJSON("/conversations/" + id, (data) => {
      callback(new Conversation(data));
    });
  }
  addMessage(msg){
    this.messages.push(msg);
    this.sortMessages();
    return this;
  }
  // Add messages lets you add many messages at once in a more efficient
  // way
  addMessages(messages){
    messages.forEach((msg) => {
      this.messages.push(msg);
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
}
