class ProductSubjectInput extends React.Component {
  constructor(props){
    super(props);
    this.state = {
      offerSubjects: props.offerSubjects,
      includedSubjects: props.includedSubjects,
      maximumSubjects: props.maximumSubjects
    };
  }
  render(){
    var includedInput = <span>
      <input type="number"
        step="1"
        onChange={this.changeNumberIncluded.bind(this)}
        value={this.state.includedSubjects} 
        min={this.state.minimumIncluded} />
    </span>;
    if(this.state.offerSubjects){
      return <div>
        <h3>Charge for Subjects</h3>
        This product will come with {includedInput} subjects free-of-charge.
        Each additional subject, up to a maximum of
        <input type="number"
          step="1.0"
          onChange={this.changeMaximum.bind(this)}
          value={this.state.maximumSubjects} />,
        will cost
        <CurrencyInputField
          min={1.00}
          initialValue={this.props.subjectPrice}
          name="commission_product[subject_price]" />.
        You can also choose to <a onClick={this.disallowSubjects.bind(this)}>
          limit the commission to a certain number of subjects,
          included in the base price.
        </a>
        <input type="hidden"
          name="commission_product[maximum_subjects]"
          value={this.state.maximumSubjects} />
        <input type="hidden"
          name="commission_product[offer_subjects]"
          value="true" />
      </div>;
    }
    else{
      return <div>
        <h3>Included Subjects</h3>
        This commission will include {includedInput} subjects in the base price.
        The client will not be allowed to add additional subjects, and will
        not recieve a discount for adding less than this amount.
        You can also chose to <a onClick={this.allowSubjects.bind(this)}>
          charge clients on a per-subject basis.
        </a>
        <input type="hidden"
          name="commission_product[offer_subjects]"
          value="false" />
      </div>
    }
  }
  disallowSubjects(){
    var n = this.state.includedSubjects;
    if(n < 1){
      n = 1;
    }
    this.setState({
      offerSubjects: false,
      minimumIncluded: 1,
      includedSubjects: n
    });
  }
  allowSubjects(){
    this.setState({
      offerSubjects: true,
      minimumIncluded: 0,
    });
  }
  changeNumberIncluded(event){
    var n = parseInt(event.target.value);
    if(n < 0){
      n = 0;
    }
    console.log("Changing the number included to",n);
    this.setState({
      includedSubjects: n
    });
  }
  changeMaximum(event){
    var n = parseInt(event.target.value);
    if(n < 1){
      n = 1;
    }
    console.log("Changing the maximum number of subjects to", n);
    this.setState({
      maximumSubjects: n
    });
  }
}
