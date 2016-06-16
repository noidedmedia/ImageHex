import App from './app.es6';
import * as Actions from './actions.es6';
import { createStore, applyMiddleware } from 'redux';
import thunkMiddleware from 'redux-thunk';
import BindChatChannel from './chat_channel.es6';
import ConversationList from './components/conversation_list.es6.jsx';
import StatusDisplay from './components/status_display.es6.jsx';

class Chat extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
    let store = createStore(
      App,
      applyMiddleware(thunkMiddleware)
    );
    this.store = store;
    store.subscribe(() => {
      this.setState(store.getState());
    });
  }

  render() {
    const unreadMap = this.getUnreadMap();

    return <div id="chat">
      <ConversationList
        unreadMap={unreadMap}
        conversations={this.state.conversations}
        messages={this.state.messages}
        active={this.state.active}
        users={this.state.users} 
        activeConversation={this.state.activeConversation} />
      <StatusDisplay
        online={this.state.online}
        active={this.state.active} />
    </div>;
  }

  componentDidMount() {
    BindChatChannel(this.store);
    this.store.dispatch(Actions.getConversations());
  }

  getUnreadMap() {
    var unreadMap = {};
    // First, by default everything is false
    for(var i in this.state.conversations) {
      unreadMap[i] = false;
    }
    // Now, go through all messages, and see if something is unread
    for(var i in this.state.messages) {
      let msg = this.state.messages[i];
      let cid = msg.conversation_id;
      // No need to check again
      if(unreadMap[cid]) {
        continue;
      }
      // if message is unread
      if(new Date(msg.created_at) > this.state.readTimes[cid]) {
        unreadMap[cid] = true;
      }
    }
    return unreadMap;
  }

  getChildContext() {
    return {
      store: this.store,
      dispatch: (action) => {
        this.store.dispatch(action);
      }
    };
  }
}

Chat.childContextTypes = {
  store: React.PropTypes.object,
  dispatch: React.PropTypes.func
};

window.Chat = Chat;

$(window).on("turbolinks:load", () => {
  var container = $("#chat-container");
  if(! container.has("#chat").length) {
    ReactDOM.render(<Chat />,
                    container[0]);
  } else {
    console.log("Chat has no container, not replacing");
  }
});
