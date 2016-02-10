class User{
  constructor(json){
    for (var prop in json){
      if (prop == "collections"){
        this.collections = [];
        for (var collection of json.collections){
          this.collections.push(new Collection(collection));
        }
      }
      else {
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
    if (this.hasFullData()){
      callback(this);
    }
    else {
      User.find(this.id, callback);
    }
  }

  get favoritesCollection(){
    return this.getFavoritesCollection();
  }
  // todo: refactor this out
  getFavoritesCollection(){
    return User.favoritesCollectionFor(this.id);
  }

  get creationsCollection(){
    return this.getCreationsCollection();
  }

  // todo: refactor this out
  getCreationsCollection(){
    User.creationsCollectionFor(this.id);
  }

  static find(id, callback){
    NM.getJSON("/users/" + id, (j) => {
      callback(new User(j));
    });
  }

  static favoritesCollectionFor(id){
    return new ImageCollection("/users/" + id + " /favorites", "images");
  }

  static creationsCollectionFor(id){
    return new ImageCollection("/users/" + id + "/creations", null);
  }

}


