class Tag{
  constructor(json){
    for(var prop in json){
      this[prop] = json[prop];
    }
  }
}
