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
  static createdSince(date, callback){
    var url = "/messages/by_time";
    url = url + `?after=${date}`;
    NM.getJSON(url, (data) => {
      callback(data.map(m => new Message(m)));
    });
  }
}
