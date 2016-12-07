import ActionCable from 'actioncable';
let App = {};
App.cable = ActionCable.createConsumer();

export default App;
