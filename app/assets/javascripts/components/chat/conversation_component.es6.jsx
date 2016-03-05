class ConversationComponent extends React.Component {
  constructor(props){
    super(props);
    this.state = {};
    this.fetchInfo();
  }
  render() {
    // actually have info
    if(this.state.id) {
      return <div className="conversation-component-container">
        <MessageGroupList messageGroups={this.state.messageGroups}/>
      </div>;
    }
    else {
      return <progress></progress>;
    }
  }

  fetchInfo() {
    Conversation.find(this.props.id, (conv) => {
      var c = new ConversationStore(conv);
      c.addListener((data) => {
        this.setState(data);
      });
    });
  }
}
