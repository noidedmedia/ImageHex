export function normalizeConversations(json) {
  var convs = json.conversations;
  let normalized = {};
  convs.forEach((conv) => {
    let userIds = conv.users.map((u) => u.id);
    let n = Object.assign({},conv,{userIds});
    normalized[conv.id] = n;
  });
  return normalized;
}

export function normalizeUsers(users) {
  var n = {};
  users.forEach((u) => {
    n[u.id] = u;
  });
  return n;
}
