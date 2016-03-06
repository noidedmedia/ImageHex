class CommissionOfferForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      subjects: props.initialSubjects || [],
      currentSubjectKey: 0,
      product: props.initialListing,
      hasBackground: !! props.background
    };
  }
  render() {
    var productBox;
    if (this.state.product) {
      /**
       * If the user has selected a product, render it here...
       */
      productBox = <CommissionOfferForm.ListingBox
        totalCost={this.calculateCost()}
        removeProduct={this.removeProduct.bind(this)}
        subjectsCount={this.subjectsCount()}
        hasBackground={this.state.hasBackground}
        listing={this.state.product} />
    }
    else {
      /**
       * Otherwise, display a view where the user can pick a new product
       */
      productBox = <ListingPicker
        subjectsCount={this.subjectsCount()}
        hasBackground={this.state.hasBackground}
        onAdd={this.addProduct.bind(this)} />;
    }
    return <div className="commission-offer-form-react">
      {/* Split the various parts of this long form into sections */}
      {this.backgroundSection()}
      {this.subjectSection()}
      {productBox}
      <button type="submit"
        disabled={this.isInvalid()}>
        Submit
      </button>
    </div>;
  }

  /**
   * User has changed their mind and wants to use a different product, how
   * sad. So we just remove the product reference here.
   */
  removeProduct(event) {
    event.preventDefault();
    this.setState({
      product: undefined
    });
  }

  /**
   * Check if this offer is invalid
   * It may be invlaid if it has a background on a product that doesn't allow
   * one, too many subjects, etc...
   */
  isInvalid() {
    if (this.state.product) {
      return ! this.state.product.validOffer({
        subjectsCount: this.subjectsCount(),
        hasBackground: this.state.hasBackground
      });
    }
    else {
      return true;
    }
  }

  /**
   * Render the background section of the form
   * This has 4 states, basically:
   *  Backgrounds included. Form always visible.
   *  Backgrounds charged and this offer doesn't have one. Display a button
   *    to add one
   *  Backgrounds charged and this has one. Display the relevant form.
   *  Background on an offer to a product that doesn't allow backgrounds.
   *    Display an error of some type.
   */
  backgroundSection() {
    var backgroundForm = <CommissionBackgroundForm
      product={this.state.product} 
      removeBackground={this.removeBackground.bind(this)}
      background={this.props.background}
    />;
    if (this.state.hasBackground) {
      if ( (! this.state.product) || this.state.product.allowBackground) {
        return backgroundForm;
      }
      else {
        return <div className="error">
          This product does not allow backgrounds.
          Remove this background before submitting.
          {backgroundForm}
        </div>;
      }
    }
    else {
      console.log("We do not have a background.");
      var button = "";
      if ((! this.state.product) || (this.state.product.allowBackground)) {
        button = <button type="button"
          onClick={this.addBackground.bind(this)}>
          Add a background
        </button>
      }
      return <div>
        <CommissionBackgroundForm.BackgroundRemovalFields
          background={this.props.background} />
        {button}
      </div>
    }
  }
  
  /**
   * Subjects section. Basically, just a list of subject form elements.
   * This also handles the buttons to add another subject, and if that
   * button should be visible (depending on the max subjects left in the 
   * product)
   */
  subjectSection() {
    var subjects = this.state.subjects.map((subj, index) => {
      // We set the `key` manually on items that are not persisted yet
      var id = subj.id ? subj.id : subj.key;
      console.log("Creating a subject display for subject",subj);
      if (subj.removed) {
        console.log("Subject is removed, rendering proper form...");
        return <CommissionSubjectForm.RemovedSubjectFields
          subj={subj}
          index={index}
          key={id}
        />;
      }
      else {
        return <CommissionSubjectForm 
          subj={subj}
          index={index}
          key={id}
          remove={this.removeSubject.bind(this, index)} />;
      }
    });

    var newButton = "";
    // Display a button to add another subject if its okay that the user
    // can add more
    if (this.canAddSubjects()) {
      newButton = <button onClick={this.addSubject.bind(this)}>
        Add a Subject
      </button>;
    }
    var subjectsLimit = "";
    if (this.subjectsLeft() < Infinity) {
      subjectsLimit = `You may add ${this.subjectsLeft()} more`; 
    }
    return <div className="offer-form-subjects-section">
      <h2>
        Subjects
      </h2>
      {subjectsLimit}
      <div id="offer-subject-container">
        {subjects}
      </div>
      {newButton}
    </div>
  }

  /**
   * Can we add more subjects?
   * ...
   * Look, it's not a difficult concept, okay?
   */
  canAddSubjects() {
    return this.subjectsLeft() > 0;
  }

  /**
   * How many subjects we currently have
   * Removes the subjects that have the `removed` flag set
   */
  subjectsCount() {
    return this.state.subjects.filter(s => ! s.removed).length;
  }

  addProduct(product) {
    this.setState({
      product: product
    });
  }

  addBackground() {
    this.setState({
      hasBackground: true
    });
  }

  canAddBackground() {
    if (! this.state.product) {
      return true;
    }
    else {
      return (this.state.product.includes_background 
        || this.state.product.offer_background);
    }
  }

  removeBackground() {
    this.setState({
      hasBackground: false
    });
  }

  subjectsLeft() {
    if (! this.state.product) {
      console.log("Found no product, can add infinite subjects");
      return Infinity;
    }
    
    if (this.state.product.offer_subjects) {
      return this.state.product.maximum_subjects - this.subjectsCount();
    }
    else {
      return this.state.product.included_subjects - this.subjectsCount();
    }
  }

  addSubject(event){
    event.preventDefault();
    var subj = this.state.subjects;
    subj.push({
      key: this.state.currentSubjectKey
    });
    // Use negative keys here to play nicely with our DB
    // Already existing subjects (IE, editing the offer) will have positive ids
    // Using negative keys prevents key conflicts 
    this.setState({
      subjects: subj,
      currentSubjectKey: this.state.currentSubjectKey - 1
    });
  }

  calculateCost(){
    var prod = this.state.product;
    var cost = prod.base_price;
    var paidSubjects = this.state.subjects.length - prod.included_subjects;
    if (paidSubjects > 0) {
      cost += paidSubjects * prod.subject_price;
    }
    if (! prod.includes_background && this.state.background) {
      cost += prod.background_price 
    }
    return cost;
  }

  removeSubject(index){
    console.log("Marking subject at index",index,"as removed");
    console.log("Subject we are marking:",this.state.subjects[index]);
    this.state.subjects[index].removed = true;
    this.setState({
      subjects: this.state.subjects
    });
  }
}

/**
 * Display info about the product, as well as buttons to use another 
 * and stuff like that.
 */
CommissionOfferForm.ListingBox = (props) => {
  return <div>
    <ListingDisplay
      {...props} />
    <button onClick={props.removeProduct}>
      Chose A Different Product
    </button>
    <input type="hidden"
      name="commission_offer[listing_id]"
      value={props.listing.id} />
  </div>;
}

document.addEventListener("page:change", function(){
  console.log("Commission offer form listener fires");
  var d = document.getElementById("offer-form-react-container");
  if (d) {
    var cid = d.dataset.offerId;
    if (cid) {
      CommissionOffer.find(cid, (c) => {
        console.log("Found offer:",c);
        ReactDOM.render(<CommissionOfferForm
          background={c.background}
          initialListingt={c.listing}
          initialSubjects={c.subjects}
        />, d);
      });
    }
    else {
      var pid = d.dataset.productId;
      if (pid) {
        CommissionProduct.find(pid, (c) => {
          console.log("Found product", c);
          ReactDOM.render(<CommissionOfferForm initialListing={c} />,
                          d);
        });
      }
      else {
        console.log("No product associated");
        ReactDOM.render(<CommissionOfferForm />,
                        d);
      }
    }
  }
});
