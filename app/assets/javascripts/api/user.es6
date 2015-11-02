class User{
  constructor(json){
    for(var prop in json){
      if(prop == "collections"){
        this.collections = [];
        for(var collection of json.collections){
          this.collections.push(new Collection(collection));
        }
      }
      else if(prop == "favorites"){
        this.favorites = new Collection(json.favorites);
      }
      else if(prop == "creations"){
        this.creations = new Collection(json.creations);
      }
      else{
        this[prop] = json[prop];
      }
    }
  }
  static find(id, callback){
    $.getJSON("/users/" + id, (c) => {
      callback(new User(c));
    });
  }
}


