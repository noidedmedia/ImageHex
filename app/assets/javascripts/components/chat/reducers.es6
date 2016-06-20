import * as ActionTypes from './action_types.es6';

export function conversations(state = {}, action) {
  if(action.type === ActionTypes.ADD_CONVERSATIONS) {
    return Object.assign({},
                         state,
                         action.data);
  }
  return state;
}

export function users(state = {}, action) {
  if(action.type === ActionTypes.ADD_USERS) {
    return Object.assign({},
                         state,
                         action.data);
  }
  return state;
}

export function messages(state = {}, action) {
  if(action.type === ActionTypes.ADD_MESSAGES) {
    return Object.assign({},
                         state,
                         action.data);
  }
  return state;
}

export function activeConversation(state = null, action) {
  if(action.type === ActionTypes.CHANGE_ACTIVE_CONVERSATION) {
    return action.conversation_id
  }
  return state;
}

export function online(state = false, action) {
  if(action.type === ActionTypes.GO_ONLINE) {
    return true;
  }
  if(action.type === ActionTypes.GO_OFFLINE) {
    return false;
  }
  return state;
}

export function active(state = false, action) {
  if(action.type === ActionTypes.ACTIVATE) {
    return true;
  }
  if(action.type === ActionTypes.DEACTIVATE) {
    return false;
  }
  return state;
}

export function readTimes(state = {}, action) {
  if(action.type === ActionTypes.READ_CONVERSATIONS) {
    return Object.assign({}, state, action.data);
  }
  return state;
}

export function depletedHistory(state = {}, action) {
  if(action.type === ActionTypes.MARK_DEPLETED_HISTORY) {
    var obj = {};
    obj[action.id] = true;
    return Object.assign({}, state, obj);
  }
  return state;
}

export function updating(state = false, action) {
  if(action.type === ActionTypes.START_UPDATE) {
    return true;
  }
  else if(action.type === ActionTypes.END_UPDATE) {
    return false;
  }
  return state;
}
