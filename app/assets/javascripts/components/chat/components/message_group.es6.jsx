import React from 'react';
import TransitionGroup from 'react-addons-css-transition-group';

const MessageGroup = ({messages, user}) => {
  let mdisp = messages.map((m) => (
    <li className="message" key={m.id}>
      {m.body}
    </li>
  ));
  let lastMsg = messages[messages.length - 1];
  let lastDate = new Date(lastMsg.created_at);
  return <li className="message-group">
    <div className="message-group-left">
      <img src={user.avatar_path} />
    </div>
    <div className="message-group-right">
      <span>{user.name}</span>
      <ul className="message-group-messages">
        <TransitionGroup
          transitionName="message-slide"
          transitionEnterTimeout={250}
          transitionLeaveTimeout={250}>
          {mdisp}
        </TransitionGroup>
      </ul>
    </div>
  </li>;
}

export default MessageGroup;
