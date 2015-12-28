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
    this.creations = this.getCreationsCollection();
    this.favorites = this.getFavoritesCollection();
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
  getFavoritesCollection(){
    return new ImageCollection("/users/" + this.id + " /favorites", "images");
  }
  getCreationsCollection(){
    return new ImageCollection("/users/" + this.id + "/creations", null);
  }
  static find(id, callback){
    NM.getJSON("/users/" + id, (j) => {
      callback(new User(j));
    });
  }
}


