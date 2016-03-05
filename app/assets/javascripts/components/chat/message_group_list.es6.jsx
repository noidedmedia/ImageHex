class MessageGroupList extends React.Component {
  constructor(props){
    super(props);
    this.state = {};
  }
  render() {
    var groups = this.props.messageGroups.map((group) => {
      return <MessageGroupList.MessageGroup {...group} />;
    });
    return <ul className="conversation-message-groups">
      {groups}
    </ul>;
  }
}

MessageGroupList.MessageGroup = (group) => (
  <li className="conversation-message-group">
    <div className="message-group-avatar">
      <img src={group.user.avatar_path} />
    </div>
    <div className="message-group-body">
      <div className="message-group-user-section">
        {group.user.name}
      </div>
      <ul className="message-group-messages">
        { 
          group.messages.map((g) => (
            <li>
              {g.body}
            </li>
            ))
        }
      </ul>
    </div>
  </li>
  );
