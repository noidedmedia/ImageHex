class Conversation {
  /**
   * Set a listening function, which will listen for all state changes
   */
  static find(id, callback) {
    NM.getJSON(`/conversations/${id}`, (conv) => {
      callback(conv);
    });
  }
}
