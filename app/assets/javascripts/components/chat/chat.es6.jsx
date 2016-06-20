import App from './app.es6';
import * as Actions from './actions.es6';
import { createStore, applyMiddleware } from 'redux';
import thunkMiddleware from 'redux-thunk';
import BindChatChannel from './chat_channel.es6';
import ConversationList from './components/conversation_list.es6.jsx';
import StatusDisplay from './components/status_display.es6.jsx';
import Conversation from './components/conversation.es6.jsx';

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
    const {unreadMap, activeMessages} = this.getMessageInfo();
    var conversation = <div></div>;
    if(this.state.activeConversation) {
      var cid = this.state.activeConversation;
      conversation = <Conversation
        updating={this.state.updating}
        messages={activeMessages}
        hasUnread={unreadMap[cid]}
        conversation={this.state.conversations[cid]}
        users={this.state.users}
        depletedHistory={this.state.depletedHistory[cid]}
      />;
    }
    return <div id="chat">
      <StatusDisplay
        online={this.state.online}
        active={this.state.active} />
      <ConversationList
        updating={this.state.updating}
        unreadMap={unreadMap}
        conversations={this.state.conversations}
        messages={this.state.messages}
        active={this.state.active}
        users={this.state.users} 
        activeConversation={this.state.activeConversation} />

      {conversation}

    </div>;
  }

  componentDidMount() {
    BindChatChannel(this.store);
    this.store.dispatch(Actions.getConversations());
  }

  getMessageInfo() {
    var unreadMap = {};
    var activeMessages = [];
    // First, by default everything is false
    for(var i in this.state.conversations) {
      unreadMap[i] = false;
    }
    let activeId = this.state.activeConversation;
    let foundUnreadActive = false;
    // Now, go through all messages, and see if something is unread
    for(var i in this.state.messages) {
      let msg = this.state.messages[i];
      let cid = msg.conversation_id;
      if(cid == activeId) {
        // this is the first active unread message
        // put a seperator in there to be sure
        if(new Date(msg.created_at) > this.state.readTimes[activeId] &&
            ! foundUnreadActive) {
          // Put in a seperator with a bogus user ID
          // Prevents chunking from crossing a read boundary later on
          activeMessages.push({user_id: "unread_active",
                              last_active_at: new Date(msg.created_at),
                              is_unread_flag: true});
          foundUnreadActive = true;
        }
        activeMessages.push(msg);
      }
      else if(unreadMap[cid]) {
        continue;
      }
      // if message is unread
      if(new Date(msg.created_at) > this.state.readTimes[cid]) {
        unreadMap[cid] = true;
      }
    }

    let sorted = activeMessages.sort((a, b) => (
      new Date(a.created_at) > new Date(b.created_at)
    ));

    return {
      unreadMap: unreadMap,
      activeMessages: sorted
    };
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
