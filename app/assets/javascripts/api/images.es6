class Image{
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
      else{
        this[prop] = json[prop];
      }
    }
  }
  static find(id, callback){
    $.getJSON("/images/" + id, (data) => {
      callback(new Image(data));
    });
  }
  static allImages(){
    return new ImageCollection("/images");
  }
  /**
   * Get a fully filled out version of this Image.
   * If this image already has all data, returns `this`
   * Otherwise returns a new image with all the data
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
   * If it doesn't you can use getFullData to get the full data
   */
  hasFullData(){
    return !! this.tag_groups;
  }
  /**
   * Get a new version of this image from the site.
   */
  refresh(callback){
    Image.find(this.id, callback);
  }
}

$(function(){
  Image.find(2, (img) => {
    var tag = img.tag_groups[0].tags[0];
    var imgs = tag.images();
    imgs.iteratePageImages((i) => {
      i.getFullData((d) => {
        console.log(d);
      });
    })
  });
});
