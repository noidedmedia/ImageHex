import ActionCable from 'actioncable';

let App = {};
if(window["USER_SIGNED_IN"]) {
  App.cable = ActionCable.createConsumer();
}
else {
  App.cable = null;
}

export default App;
