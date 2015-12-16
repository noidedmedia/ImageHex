class CommissionSubject{
  constructor(json){
    for(var prop in json){
      this[prop] = json[prop];
    }
    if(! this.id ){
      // Ensure a unique id for react
      this.id = Math.random();
    }
  }
}
