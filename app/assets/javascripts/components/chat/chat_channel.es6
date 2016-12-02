import * as Actions from './actions.es6';
import * as Types from './action_types.es6';
import App from '../../cable';

export default function BindChatChannel(store) {
  if(! App.cable) {
    throw "ERROR: Cable does not exist!";
  }

  App.chat = App.cable.subscriptions.create("ChatChannel", {
    connected: function() {
      store.dispatch(Actions.goOnline());
      store.dispatch(Actions.getRecentMessages());
    },

    disconnected: function() {
      store.dispatch(Actions.goOffline());
    },

    received: function(data) {
      console.info("Cable got data",data);
      if(data.type === Types.READ_CONVERSATIONS) {
        for(var i in data.data) {
          data.data[i] = new Date(data.data[i]);
        }
      }
      if(data.type === "refresh_conversation_list") {
        store.dispatch(Actions.getConversations());
      }
      else {
        store.dispatch(data);
      }
    }
  });
}
