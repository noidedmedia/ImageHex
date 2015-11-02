class Collection{
  constructor(json){
    for(var prop in json){
      if(prop !== "images"){
        this[prop] = json[prop];
      }
    }
  }
  /**
   * Find a collection
   * @param{Number} id the id of the collection
   * @param{Function} callback the callback called with the Collection
   */
  static find(id, callback){
    NM.getJSON("/collections/" + id, (json) => {
      callback(new Collection(json));
    });
  }
  /**
   * All images in this collection
   * @return{ImageCollection} a collection for the images
   */
  images(){
    return new ImageCollection("/collections/" + this.id, "images");
  }
  /**
   * Calls `callback` with the full version of this collection
   * Will call `callback` with `this` as the argument if this is already
   * a fully-formed collection.
   */
  getFull(callback){
    if('curators' in this){
      callback(this);
    }
    else{
      Collection.find(this.id, callback);
    }
  }
}
