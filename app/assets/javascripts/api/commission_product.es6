class CommissionProduct{
  constructor(json){
    for(var prop in json){
      this[prop] = json[prop];
    }
  }
  static find(id, callback){
    NM.getJSON("/commission_products/" + id, (j) => {
      callback(new CommissionProduct(j));
    });
  }
  buildOffer(){
    return new CommissionOffer({
      product: this,
      subjects: [],
      background: null
    });
  }
}
