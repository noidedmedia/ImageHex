import NM from '../../api/global.es6';

function startSending(){
  return {
    type: "start_sending"
  };
}

function endSending() {
  return {
    type: "end_sending"
  };
}

function addMessages(messages) {
  return {
    type: "add_messages",
    messages: messages
  };
}

function sendMessage(message) {
  return function(dispatch, getState) {
    dispatch(startSending());
    var {messages, id} = getState();
    var lastUpdate = messages[messages.length - 1].created_at;

    return NM.postJSON(`/conversations/${id}/messages`, {
                      message: {body: message}})
      .then(response => {
        dispatch(endSending());
        var fetchTime = new Date(lastUpdate.getTime() + 1000);
        dispatch(fetchAfter(fetchTime));
      });
  }
}

function startFetch() {
  return {
    type: "start_fetching"
  };
}

function endFetch() {
  return {
    type: "end_fetching"
  };
}

/**
 * Async action to fetch all messages created after a given date.
 * If no date passed, fetch all messages created after the most recent message.
 */
function fetchAfter(date) {
  return function(dispatch, getState) {
    console.log("NM is",NM);
    dispatch(startFetch());
    var { messages, id } = getState();
    if(date === undefined) {
      date = messages[messages.length - 1].created_at;
      date = new Date(date.getTime() + 1000);
    }
    var time = date.getTime() / 1000;
    return NM.getJSON(`/conversations/${id}/messages?after=${time}`)
      .then(json => {
        dispatch(endFetch());
        json.forEach(m => m.created_at = new Date(m.created_at));
        dispatch(addMessages(json));
      });
  }
}

function setTimeToPoll(time) {
  return {
    type: "set_poll_time",
    time: time
  };
}

function pollUpdate(time) {
  return function(dispatch, getState) {
    var newTime = time - 1;
    if(newTime <= 0) {
      dispatch(fetchAfter())
      dispatch(pollUpdate(30));
    }
    else {
      dispatch(setTimeToPoll(newTime));
      window.setTimeout(() => {
        dispatch(pollUpdate(newTime));
      }, 1000);
    }
  }
}
export { sendMessage, fetchAfter, pollUpdate }
