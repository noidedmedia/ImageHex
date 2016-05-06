import NM from './global.es6';

class Conversation {
  /**
   * Set a listening function, which will listen for all state changes
   */
  static find(id, callback) {
    NM.getJSON(`/conversations/${id}`, (conv) => {
      conv.messages.forEach((m) => m.created_at = new Date(m.created_at));
      callback(conv);
    });
  }
}

export default Conversation;
