class Tag{
  constructor(json){
    for(var prop in json){
      this[prop] = json[prop];
    }
  }

  static create(props, callback){
    var c = (tag) => {
      console.log("Create gave us a new tag");
      callback(new Tag(tag));
    };
    NM.postJSON("/tags/",
                props,
                c);
  }
  getFullData(callback){
    if("description" in this){
      callback(this);
    }
    else{
      Tag.find(this.id, callback);
    }
  }
  /**
   * Get an ImageCollection representing all images with this tag.
   */
  images(){
    return new ImageCollection("/tags/" + this.id, "images");
  }
  /**
   * Find a tag by an ID or a slug.
   * @param{(number|string)} id the id or slug of the tag
   * @param{Function} callback the callback to call with the Tag
   */
  static find(id, callback){
    NM.getJSON("/tags/" + id, (t) => {
      callback(new Tag(t));
    });
  }
  /**
   * Get all tags with a prefix
   * @param{String} prefix the prefix
   * @param{Function} callback called with the array of tags
   */
  static withPrefix(prefix, callback){
    var uri = "/tags/suggest/?"+ $.param({name: prefix});
    $.getJSON(uri, (d) => {
      var a = [];
      for(var t of d){
        a.push(new Tag(t));
      }
      callback(a);
    });
  }
}
