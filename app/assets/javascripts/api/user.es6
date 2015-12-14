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
  hasFullData(){
    return "description" in this;
  }
  getFullData(callback){
    if(this.hasFullData()){
      callback(this)
    }
    else{
      User.find(this.id, callback);
    }
  }
  favorites(){
    return new ImageCollection("/users/" + this.id + " /favorites", "images");
  }
  creations(){
    return new ImageCollection("/users/" + this.id + "/creations", "images");
  }
  static find(id, callback){
    NM.getJSON("/users/" + id, (j) => {
      callback(new User(j));
    });
  }
}


