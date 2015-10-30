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
}

$(function(){
  var a = Image.allImages();
  console.log(a);
  a.iteratePageImages((img) => {
    console.log(img);
  });
});

