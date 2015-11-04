/**
 * Reperesent a single image
 */
class Image{
  /**
   * Construct a new image. 
   * Never call this youself, use `find` instead.
   */
  constructor(json){
    for(var prop in json){
      if(prop == "tag_groups"){
        this.tag_groups = []
        for(var group of json.tag_groups){
          group.image_id = json.id
          group.image = this;
          this.tag_groups.push(new TagGroup(group));
        }
      }
      else if(prop == "creators"){
        this.creators = [];
        for(var creator of json.creators){
          this.creators.push(new User(creator));
        }
      }
      else{
        this[prop] = json[prop];
      }
    }
  }
  /**
   * Find the image with id `id`.
   * Calls `callback` with the result.
   * @param{Number} id the id of the image
   * @param{Function} callback the function to call with the image object
   */
  static find(id, callback){
    NM.getJSON("/images/" + id, (data) => {
      callback(new Image(data));
    });
  }
  /**
   * Get a collection representing all images.
   */
  static allImages(){
    return new ImageCollection("/images");
  }
  /**
   * Get a fully filled out version of this Image.
   * If this image already has all data, returns `this`
   * Otherwise returns a new image with all the data
   * @param{Function} callback the function to call with the full image
   */
  getFullData(callback){
    if(this.hasFullData()){
      callback(this);
    }
    else{
      Image.find(this.id, callback);
    }
  }
  /**
   * See if this image has full data, IE tags and groups
   * If it doesn't you can use getFullData to get the full data.
   * @return{Bool} a boolean value indicating if this image is fully formed.
   */
  hasFullData(){
    return !! this.tag_groups;
  }
  /**
   * Get a new version of this image from the site.
   * @param{Function} callback the function to call with the refreshed image
   */
  refresh(callback){
    Image.find(this.id, callback);
  }
}
