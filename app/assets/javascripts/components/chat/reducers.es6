function users(state = {}, action) {
  if(action.type === "add_user") {
    var usr = action.data.user;
    var obj = {};
    obj[usr.id] = usr;
    return Object.assign({},state,obj);
  }
  return state;
}

function id(state = 0, action){
  return state;
}

function name(state = "", action) {
  return name;
}

function messages(state = [], action) {
  if(action.type === "add_messages") {
    return [
      ...state,
      ...action.messages
    ].sort((a, b) => a.created_at - b.created_at);
  }
  return state;
}

function lastRead(state = 0, action) {
  if(action.type === "read_messages") {
    return action.data.date;
  }
  return state;
}

function isFetching(state = false, action) {
  if(action.type === "start_fetching") {
    return true;
  }
  if(action.type === "end_fetching") {
    return false;
  }
  return state;
}

function isSending(state = false, action) {
  if(action.type === "start_sending") {
    return true;
  }
  if(action.type === "end_sending") {
    return false;
  }
  return state;
}

export {users, messages, lastRead, name, id, isFetching, isSending};
