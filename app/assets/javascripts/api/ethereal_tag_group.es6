class EtherealTagGroup{
  /**
   * Optionally takes a JSON describing an ethereal group
   */
  constructor(param){
    if(param && typeof(param) == "object"){
      for(var prop in param){
        if(prop == "tags"){
          this.tags = [];
          for(var tag of param.tags){
            this.tags.push(new Tag(tag));
          }
        }
        else{
          this[prop] = param[prop];
        }
      }
    }
    else{
      this.tags = [];
    }
  }
  removeTag(tag){
    for(var t in this.tags){
      if(this.tags[t].id === tag.id){
        this.tags.splice(t, 1);
      }
    }
  }
  addTag(tag){
    this.tags.push(tag);
  }
}
