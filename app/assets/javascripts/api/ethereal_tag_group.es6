class EtherealTagGroup{
  constructor(){
    this.tags = [];
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
