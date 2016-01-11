class CommissionOffer{
  constructor(json){
    for(var prop in json){
      if(prop === "product"){
        this.product = new CommissionProduct(json.product);
      }
      else{
        this[prop] = json[prop];
      }
    }
  }
  static find(id, callback){
    NM.getJSON(`/commission_offers/${id}`, (c) => {
      callback(new CommissionOffer(c));
    });
  }
}
