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

export function startUpdate() {
  return {
    type: Types.START_UPDATE
  };
}

export function endUpdate() {
  return {
    type: Types.END_UPDATE
  };
}

export function getConversations() {
  return async function(dispatch, getState) {
    dispatch(startUpdate());
    try {
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
    }
    catch(err) {
      console.error("Got error",err);
    }
    finally {
      dispatch(endUpdate());
    }
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
  return {
    type: Types.CHANGE_ACTIVE_CONVERSATION,
    conversation_id: id
  };
}

export function markRead(cid) {
  return async function(dispatch, getState) {
    try {
      let url = `/conversations/${cid}/read`;
      let q = await NM.postJSON(url, {});
      console.log("Server#read response:",q);
      let v = new Date(q);
      console.log("From reading conversation, got date",v);
      let o = {};
      o[cid] = v;
      dispatch({
        type: Types.READ_CONVERSATIONS,
        data: o
      });
    }
    catch(err) {
      console.error(err);
    }
  }
}


export function getHistoryBefore(date, cid) {
  return async function(dispatch, getState) {
    dispatch(startUpdate());
    try {
      let beforeSeconds = date.getTime() / 1000;
      let url = `/conversations/${cid}/messages?before=${beforeSeconds}`;
      console.log("Getting history with url",url);
      let j = await NM.getJSON(url);
      let norm = NM.shallowNormalize(j, "id");

      if(j.length === 0) {
        dispatch(markDepletedHistory(cid));
      }
      else {
        dispatch({
          type: Types.ADD_MESSAGES,
          data: norm
        });
      }
    }
    catch(err) {
      console.error(err);
    }
    finally {
      dispatch(endUpdate());
    }
  }
}

export function markDepletedHistory(cid) {
  return {
    type: Types.MARK_DEPLETED_HISTORY,
    id: cid
  };
}
