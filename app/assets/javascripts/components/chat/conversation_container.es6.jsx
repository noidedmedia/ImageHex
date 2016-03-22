import { createStore, applyMiddleware } from 'redux';
import thunk from 'redux-thunk';
import { chatApp } from './app.es6';
import NM from '../../api/global.es6';
import MessageGroupList from './message_group_list.es6.jsx';
import MessageInput from './message_input.es6.jsx';
import { pollUpdate } from './actions.es6';

function addReadDivider(messages, date) {
  console.log("Adding a read divider after date:",date);
  for(var i = 0; i < messages.length; i++) {
    if(messages[i].created_at > date) {
      var m = messages.slice(0);
      m.splice(i, 0, {user_id: "divider"});
      return m;
    }
  }
  return messages;
}

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
    id: props.id,
    lastRead: new Date(props.last_read)
  };
}

class ConversationContainer extends React.Component {
  constructor(props) {
    console.log(chatApp);
    super(props);
    let store = applyMiddleware(thunk)(
      createStore)(chatApp, normalizeData(this.props));
    this.store = store;
    this.state = store.getState();
    store.subscribe(() => {
      this.setState(store.getState());
    });
  }

  render() {
    var groups = addReadDivider(this.state.messages, this.state.lastRead);
    groups = NM.chunk(groups, "user_id");
    return <div className="conversation-component-container">
      <h1>{this.state.name}</h1>
      <MessageGroupList
        messageGroups={groups}
        users={this.state.users} 
        fetching={this.state.isFetching}
        dispatch={this.store.dispatch}
        lastRead={this.state.lastRead}  />
      <PollDisplay {...this.state} />
      <MessageInput
        dispatch={this.store.dispatch}
        sending={this.state.isSending}
        fetching={this.state.isFetching} />
    </div>;
  }

  componentDidMount() {
    this.store.dispatch(pollUpdate(5));
  }
}

const PollDisplay = ({timeToPoll, isFetching}) => {
  if(isFetching) {
    return <progress></progress>;
  }
  else {
    return <span>Fetching in {timeToPoll}</span>;
  }
}

window.ConversationContainer = ConversationContainer;
export default ConversationContainer;
