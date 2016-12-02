import React from 'react';
import { changeConversation, deactivate } from '../actions.es6';

export default class ConversationDropdown extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    return <div className={this.getClassName()}>
      <ul className="conversations-list">
        {this.conversations()}
      </ul>
      <a href="/conversations/new"
        className="add-conversation-link">

      </a>
    </div>;
  }

  getClassName() {
    var cn = "conversation-dropdown";
    if(this.props.active) {
      cn += " active";
    }
    else {
      cn += " inactive";
    }
    return cn;
  }

  conversations() {
    var c = [];
    for(var i in this.props.conversations) {
      let conv = this.props.conversations[i];
      let users = this.usersForConversation(conv);
      c.push(<ConversationItem
        key={i}
        conversation={conv}
        unreadCount={this.props.unreadMap[i]}
        users={users}
        activate={this.activate.bind(this, i)}
        active={i === this.props.activeConversation} />);
    }
    return c;
  }

  usersForConversation(conv) {
    return conv.userIds.map((id) => this.props.users[id]);
  }

  activate(id) {
    this.context.dispatch(changeConversation(id));
    this.context.dispatch(deactivate());
  }
}

ConversationDropdown.contextTypes = {
  store: React.PropTypes.object,
  dispatch: React.PropTypes.func
};

const ConversationItem = (props) => {
  var className = "conversation-item flex-row";
  var click = () => {};
  if(props.active) {
    className += " active";
  }
  else {
    click = props.activate;
  }
  if(props.unreadCount > 0) {
    className += " has-unread";
  }
  let ud = props.users.map(userDisplay);
  return <li className={className}
    onClick={click}>

    <div className="unread-count">
      {props.unreadCount}
    </div>

    <div className="full-width">
      <h4>{props.conversation.name}</h4>
      <ul className="conversation-users-list">
        {ud}
      </ul>
    </div>
  </li>;
};

function userDisplay(u, index) {
  if(u) {
    return <li key={u.id}>
      <img src={u.avatar_path} />
    </li>
  }
  else {
    return <li key={index}>
    </li>;
  }
}
