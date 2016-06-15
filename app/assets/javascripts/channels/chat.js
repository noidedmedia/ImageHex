App.chat = App.cable.subscriptions.create("ChatChannel", {
  connected: function() {
    console.log("Connected");
  },

  disconnected: function() {
    console.log("Disconnected");
  },

  received: function(data) {
    console.log(data);
  }
});

