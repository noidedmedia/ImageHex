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
    var id = getState().id;
    return NM.postJSON(`/conversations/${id}/messages`, {
                      message: {body: message}})
      .then(response => {
        dispatch(endSending());
        response.created_at = new Date(response.created_at);
        dispatch(addMessages([response]));
      });
  }
}

export { sendMessage }
