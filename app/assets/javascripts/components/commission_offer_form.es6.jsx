class CommissionOfferForm extends React.Component{
  constructor(props){
    super(props);
    this.state = {
      subjects: [],
      background: [],
      currentSubjectKey: 0,
    };
  }
  render(){
    return <div>
      {this.subjectSection()}
      <span className="offer-cost">
        Total cost is ${(this.calculateCost() / 100).toFixed(2)} 
      </span>
    </div>;
  }
  // Returns the HTML for the subject section
  subjectSection(){
    var subjects = this.state.subjects.map((subj, index) => {
      // We set the `key` manually on items that are not persisted yet
      var id = subj.id ? subj.id : subj.key;
      return <CommissionSubjectForm 
        subj={subj}
        index={index}
        key={id}
        remove={this.removeSubject.bind(this, index)} />;
    });
    var newButton;
    if(this.canAddSubjects()){
      newButton = <button onClick={this.addSubject.bind(this)}>
        Add a Subject
      </button>;
    }
    else{
      newButton = "";
    }
    
    return <div>
      <h1>
        Subjects
      </h1>
      You may add {this.subjectsLeft()} more.
      <div id="offer-subject-container">
        {subjects}
      </div>
      {newButton}
    </div>
  }
  canAddSubjects(){
    return this.subjectsLeft() > 0;
  }
  subjectsLeft(){
    if(this.props.product.offer_subjects){
      return this.props.product.maximum_subjects - this.state.subjects.length;
    }
    else{
      return this.props.product.included_subjects - this.state.subjects.length;
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
    var prod = this.props.product;
    var cost = prod.base_price;
    var paidSubjects = this.state.subjects.length - prod.included_subjects;
    if(paidSubjects > 0){
      cost += paidSubjects * prod.subject_price;
    }
    return cost;
  }
  removeSubject(index){
    this.state.subjects.splice(index, 1);;
    this.setState({
      subjects: this.state.subjects
    });
  }
}


document.addEventListener("page:change", function(){
  console.log("Commission offer form listener fires");
  var d = document.getElementById("offer-form-react-container");
  if(d){
    var id = d.dataset.productId;
    CommissionProduct.find(id, (c) => {
      console.log("Found product", c);
      ReactDOM.render(<CommissionOfferForm product={c} />,
                      d);
    });
  }
});
