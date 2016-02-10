class Collection {
  constructor(json) {
    for (var prop in json) {
      if (prop !== "images") {
        this[prop] = json[prop];
      }
    }
  }

  removeImageWithId(id, callback) {
    console.log("trying to remove image with id", id);
    NM.deleteJSON("/collections/" + this.id + "/images/" + id,
                  callback);
  }
  
  addImageWithId(id, callback) {
    console.log("Trying to add image with id",id);
    NM.postJSON("/collections/" + this.id + "/images", 
      {
        collection_image: {
                    image_id: id
                  }
      }, 
                (c) => {
                  callback(true);
                });
  }

  /**
   * Find a collection
   * @param{Number} id the id of the collection
   * @param{Function} callback the callback called with the Collection
   */
  static find(id, callback) {
    NM.getJSON("/collections/" + id, (json) => {
      callback(new Collection(json));
    });
  }

  /**
   * Inspect the current users's collections, seeing
   * if they contain an image or not.
   * @param{Number} id the id of the image to inspect
   * @param{Function} callback callback to call with data
   * @return{[CollectionStub]} the users collections
   */
  static inspectForImage(id, callback) {
    NM.getJSON("/collections/mine?inspect_image=" + id, (json) => {
      callback(json.map((j) => {
        return new Collection(j);
      }));
    });
  }

  /**
   * All images in this collection
   * @return{ImageCollection} a collection for the images
   */
  images() {
    return new ImageCollection("/collections/" + this.id, "images");
  }

  /**
   * Calls `callback` with the full version of this collection
   * Will call `callback` with `this` as the argument if this is already
   * a fully-formed collection.
   */
  getFull(callback) {
    if ("curators" in this) {
      callback(this);
    } else {
      Collection.find(this.id, callback);
    }
  }
}
