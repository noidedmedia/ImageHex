class CommissionProduct{
  constructor(json){
    for (var prop in json){
      this[prop] = json[prop];
    }
  }
  static find(id, callback){
    NM.getJSON("/commission_products/" + id, (j) => {
      callback(new CommissionProduct(j));
    });
  }
  calculateCost(props){
    var {subjectsCount, hasBackground} = props;
    console.log(`Calculating cost with subjectsCount of ${subjectsCount} and
                background value of ${hasBackground}`);
    var basePrice = this.base_price;
    basePrice += this.subject_price * (subjectsCount - this.included_subjects);
    if (this.offer_background && hasBackground){
      basePrice += this.background_price;
    }
    return basePrice;
  }
  validOffer(props){
    var {subjectsCount, hasBackground} = props;
    if (subjectsCount > this.maximumSubjects()){
      console.log(`Offer's subject count of ${subjectsCount} is too high.
                  Offer is invalid.`);
      return false;
    }
    else if (this.disallowBackground() && hasBackground){
      console.log(`Offer has a background, which it cannot have.
                  Offer is invalid.`);
    }
    return true;
  }
  // yeah this is a bad way to do this, whatever
  disallowBackground(){
    return (! this.includes_backgrond) && (! this.offer_background);
  }

  allowBackground(){
    return ! this.disallowBackground();
  }
  maximumSubjects(){
    if (this.offer_subjects){
      return this.maximum_subjects;
    }
    else {
      return this.included_subjects;
    }
  }
  static withCriteria(criteria, page, callback){
    console.log("Finding products with criteria",criteria);
    var baseURL = "/commission_products/search";
    var {subjectsCount, hasBackground} = criteria;
    baseURL += `?subjects_count=${encodeURIComponent(subjectsCount)}`;
    baseURL += `&has_background=${encodeURIComponent(hasBackground)}`;
    baseURL += `&page=${encodeURIComponent(page)}`;
    console.log(`Fetching with URL: ${baseURL}`);
    NM.getJSON(baseURL, (d) => {
      console.log("Got products meeting some criteria",d);
      callback(d.map(e => new CommissionProduct(e)));
    });
  }
}
