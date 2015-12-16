class CommissionOfferForm extends React.Component{
  constructor(props){
    super(props);
    this.state = {
      subjects: [],
      background: [],
    };
  }
  render(){
    var subjects = this.state.subjects.map((subj, index) => {
      return <CommissionSubjectForm 
        descriptionChange={this.changeSubjectDescription.bind(this, index)}
        remove={this.removeSubject.bind(this, index)} />;
    });
    return <div>
      <span className="offer-cost">
        Total cost is {this.calculateCost()}
      </span>
    </div>;
  }
  calculateCost(){
    return "";
  }
  removeSubject(index){
    this.state.subjects.splice(subj, index);
    this.setState({
      subjects: this.state.subjects
    });
  }
  changeSubjectDescription(index, event){
    var subj = this.state.subjects[index];
    subj.description = event.target.value;
    this.setState({
      subjects: this.state.subjects
    });
  }
  addSubject(){
    this.state.subjects.push({
      description: "",
      tags: []
    });
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
