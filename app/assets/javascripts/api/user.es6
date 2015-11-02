class User{
  constructor(json){
    for(var prop in json){
      if(prop == "collections"){
        this.collections = [];
        for(var collection of json.collections){
          this.collections.push(new Collection(collection));
        }
      }
      else{
        this[prop] = json[prop];
      }
    }
  }
  static find(id, callback){
    NM.getJSON("/users/" + id, (j) => {
      callback(new User(j));
    });
  }
}

$(() => {
  User.find(2, (u) => {
    console.log(u);
  });
});
