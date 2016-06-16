import * as Actions from './actions.es6';

export default function BindChatChannel(store) {
  if(! App.cable) {
    throw "ERROR: Cable does not exist!";
  }
  App.chat = App.cable.subscriptions.create("ChatChannel", {
    connected: function() {
      store.dispatch(Actions.goOnline());
    },

    disconnected: function() {
      store.dispatch(Actions.goOffline());
    },

    received: function(data) {
      console.log("From server, got data",data);
      store.dispatch(data);
    }
  });
}
