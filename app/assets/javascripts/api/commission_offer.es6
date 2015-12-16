class CommissionOffer{
  constructor(json){
    this.subjects = [];
    for(var prop in json){
      if(prop == "subjects"){
        for(var i = 0; i < json.subjects.length; i++){
          this.subjects[i] = new CommissionSubject(json.subjects[i]);
        }
      }
      else{
        this[prop] = json[prop];
      }
    }
  }
  buildSubject(){
    this.subjects.push(new CommissionSubject());
  }
  getPrice(){
    if(! this.product){
      return undefined;
    }
    var price = 0;
    price += this.product.base_price;
    var paidSubjects = this.subjects.length - this.product.included_subjects;
    if(paidSubjects > 0){
      price += paidSubjects * this.product.subject_price;
    }
    if(this.background && !this.product.includes_background){
      price += this.product.background_price;
    }
    return price;
  }
}
