class UserComponent extends React.Component{
  constructor(props){
    super(props);
    this.state = {
      fully_loaded: this.props.user.hasFullData()
    }
  }
  render(){
    return <div className="react-user">
      <img src={this.props.user.avatar_path} />
      <h3>{this.props.user.name}</h3>
      {this.moreInfo()}
    </div>;
  }
  moreInfo(){
    if(this.state.fully_loaded){
      console.log("Fully loaded already");
      return <div className="react-user-additional-info">
        <div className="react-user-description">
          {this.state.user.description}
        </div>
        {this.userCreations()}
      </div>
    }
    else{
      console.log("not fully loaded");
      return <div onClick={this.loadInfo.bind(this)}>Info</div>
    }
  }
  loadInfo(){
    console.log("Trying to load info");
    console.log("Oour user property is",this.props.user);
    this.props.user.getFullData((u) => {
      console.log("Got full info with user",u);
      this.setState({
        user: u,
        fully_loaded: true
      });
    });
  }
  userCreations(){
    if(this.state.showCreations){
      return <ImageCollectionComponent collection={this.props.user.creations()} />;
    }
    else{
      return <div onClick={this.toggleCreations.bind(this)}>
        Show creations
      </div>;
    }
  }
  toggleCreations(){
    this.setState({
      showCreations: true
    });
  }
}

