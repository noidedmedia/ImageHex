import { createStore, applyMiddleware } from 'redux';
import thunk from 'redux-thunk';
import { chatApp } from './app.es6';
import NM from '../../api/global.es6';
import MessageGroupList from './message_group_list.es6.jsx';

function normalizeData(props) {
  var users = {};
  props.users.forEach((u) => users[u.id] = u);
  props.messages.forEach((msg) => {
    msg.created_at = new Date(msg.created_at);
  });
  return {
    users: users,
    messages: props.messages,
    name: props.name,
    id: props.id
  };
}

class ConversationContainer extends React.Component {
  constructor(props) {
    console.log(chatApp);
    super(props);
    let store = applyMiddleware(thunk)(
      createStore)(chatApp, normalizeData(this.props));
    this.state = store.getState();
    store.subscribe((store) => {
      this.setState(store.getState());
    });
  }

  render() {
    var messageGroups = NM.chunk(this.state.messages, "user_id");
    return <div>
      <MessageGroupList
        messageGroups={messageGroups} 
        users={this.state.users} />
    </div>;
  }

  componentDidMount() {
  }
}

window.ConversationContainer = ConversationContainer;

export default ConversationContainer;
