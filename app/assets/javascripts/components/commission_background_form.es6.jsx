class CommissionBackgroundForm extends React.Component{
  constructor(props){
    super(props);
    this.state = {};
  }
  render(){
    return <div>
      <textarea name="commission_offer[backgrounds_attributes][0][description]">
      </textarea>
    </div>
  }
}
