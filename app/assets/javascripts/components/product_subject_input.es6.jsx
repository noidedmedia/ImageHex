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
        name="commission_product[included_subjects]"
        defaultValue="0"
        min={this.findMinimumIncluded()} />
    </span>;
    var chargeSection = <ProductSubjectInput.ChargedSubjectSection />;
    var disallowChargeSection = <input type="hidden"
      name="commission_product[offer_subjects]"
      value="false" />;
    return <div>
      <h3>Included Subjects</h3>
      This commission will include {includedInput} subjects, free of charge.
      <div className="checkbox-container">
        <input type="checkbox"
          name="commission_product[offer_subjects]"
          value={this.state.allowAdditional}
          onChange={this.toggleAdditional.bind(this)} />
        <label>Charge for additional subjects</label>
      </div>
      {this.state.allowAdditional ? chargeSection : disallowChargeSection}
    </div>;
  }
  toggleAdditional(event){
    console.log(`Targeting additional to ${event.target.checked}`);
    this.setState({
      allowAdditional: event.target.checked
    });
  }
  findMinimumIncluded(){
    return this.state.allowAdditional ? 0 : 1;
  }

}

ProductSubjectInput.ChargedSubjectSection = () => {
  return <div>
    Charge 
    <CurrencyInputField
      min={1.00}
      initialValue="5.0"
      name="commission_product[subject_price]" />
    for each additional subject, to a max of
    <input type="number"
      step="1.0"
      name="commission_product[maximum_subjects]"
      initialValue="1"
      min="1" />
  </div>;
};
