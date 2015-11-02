class Tag{
  constructor(json){
    for(var prop in json){
      this[prop] = json[prop];
    }
  }
  /**
   * Get an ImageCollection representing all images with this tag.
   */
  images(){
    return new ImageCollection('/tags/' + this.id, 'images');
  }
  /**
   * Find a tag by an ID or a slug.
   * @param{(number|string)} id the id or slug of the tag
   * @param{Function} callback the callback to call with the Tag
   */
  static find(id, callback){
    $.getJSON("/tags/" + id, (t) => {
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
    console.log("Suggesting with URI:",uri);
    $.getJSON(uri, (d) => {
      console.log("Got from suggestion",d);
      var a = [];
      for(var t of d){
        a.push(new Tag(t));
      }
      callback(a);
    });
  }
}
