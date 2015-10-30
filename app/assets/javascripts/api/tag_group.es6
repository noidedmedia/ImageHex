class TagGroup{
  constructor(json){
    for(var prop in json){
      if(prop == "tags"){
        this.tags = []
        for(var tag of json.tags){
          this.tags.push(new Tag(tag)); 
        }
      }
      else{
        this[prop] = json[prop]
      }
    }
  }
}

