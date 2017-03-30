import App from '../../cable';

if(App.cable && App.cable.subscriptions) {
  App.notifications = App.cable.subscriptions.create("NotificationsChannel", {
    connected: function() {

    },

    disconnected: function() {
      // Called when the subscription has been terminated by the server
    },

    received: function(data) {
      let d = JSON.parse(data);
      console.log("Recieved data",d);
      if(App.notifications.listener) {
        App.notifications.listener(d);
      }
    }
  });
}
else {
  App.notifications = null;
}

export default App.notifications;
