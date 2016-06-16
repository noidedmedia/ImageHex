import * as Types from './action_types.es6';
import NM from '../../api/global.es6';
import {normalizeConversations, normalizeUsers} from './normalizers.es6';

export function goOffline() {
  return {
    type: Types.GO_OFFLINE
  };
}

export function goOnline() {
  return {
    type: Types.GO_ONLINE
  };
}

export function addUsersNormalized(users) {
  return {
    type: Types.ADD_USERS,
    data: users
  };
}

export function getConversations() {
  return async function(dispatch, getState) {
    const convs = await NM.getJSON("/conversations/");
    let normalized = normalizeConversations(convs);

    dispatch({
      type: Types.ADD_CONVERSATIONS,
      data: normalized
    });

    let userExtract = NM.flatten(convs.conversations.map((c) => c.users));
    let userNormalized = normalizeUsers(userExtract);

    dispatch(addUsersNormalized(userNormalized));

    let readTimes = {};
    convs.conversations.forEach((c) => {
      readTimes[c.id] = new Date(c.last_read_time);
    });

    dispatch({
      type: Types.READ_CONVERSATIONS,
      data: readTimes
    });
  };
}

export function activate() {
  return {
    type: Types.ACTIVATE
  };
}

export function deactivate() {
  return {
    type: Types.DEACTIVATE
  };
}

export function changeConversation(id) {
  console.log("Change conversation to",id);
  return {
    type: Types.CHANGE_ACTIVE_CONVERSATION,
    conversation_id: id
  };
}
