import Conversation from '../../api/conversation.es6';
import ConversationStore from '../../stores/conversation_store.es6';
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
        <MessageInput
          onAdd={this.addMessage.bind(this)} />
        <div className="update-timing">
          Updating in {this.state.timeToUpdate} seconds...
        </div>
      </div>;
    }
    else {
      return <progress></progress>;
    }
  }

  addMessage(msg) {
    this.state.store.addMessage(msg);
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

window.ConversationComponent = ConversationComponent;
export default ConversationComponent;
