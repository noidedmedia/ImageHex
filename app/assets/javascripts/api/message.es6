class Message{
  constructor(obj){
    for(var prop in obj){
      this[prop] = obj[prop];
    }
  }
  static unread(callback){
    NM.getJSON("/messages/unread", (msg) => {
      var mapped = msg.map((m) => new Message(m));
      callback(mapped);
    });
  }
}
