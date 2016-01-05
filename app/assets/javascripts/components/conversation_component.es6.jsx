class ConversationComponent extends React.Component{
  constructor(props){
    super(props);
    this.state = {}
  }
  render(){
    return <div>
      Conversation with id #{this.props.conversation.id}
    </div>
  }
}
