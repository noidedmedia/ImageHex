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
  if(action.type === "add_message") {
    return [
      ...state,
      action.data.message
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

export {users, messages, lastRead, name, id};
