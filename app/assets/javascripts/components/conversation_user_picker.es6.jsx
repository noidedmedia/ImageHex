import NM from '../api/global.es6';


const UserInfo = (user) => (
  <div className="user-info flex-row">
    <img src={user.avatar_path} />
    <div className="user-name">
      {user.name}
    </div>
  </div>
);

const PossibleUser = ({user, onAdd}) => (
  <li className="possible-users-item user-adder-item flex-row">
    <UserInfo {...user} />
    <div className="add-button action-button"
      onClick={onAdd}>
      Add
    </div>
  </li>
);

const SelectedUser = ({user, onRemove}) => (
  <li className="selected-users-item user-adder-item flex-row">
    <UserInfo
      {...user} />
    <div className="remove-button action-button"
      onClick={onRemove}>
      Remove
    </div>
    <input
      type="hidden"
      name="conversation[user_ids][]"
      value={user.id} />
  </li>
);

function indexOfBSearch(array, needle, compare, start, end) {
  if(start == undefined) {
    start = 0;
  }
  if(end == undefined) {
    end = array.length - 1;
  }
  if(start > end) {
    return -1;
  }
  let mid = Math.floor((end + start) / 2);
  let current = array[mid];
  let comp = compare(needle, current);
  // Equal
  if(comp == 0) {
    return mid;
  }
  // needle > current, look in the larger half
  else if(comp > 0) {
    return indexOfBSearch(array, needle, compare, mid + 1, end);
  }
  // needle < current, look in smaller half
  else if(comp < 0) {
    return indexOfBSearch(array, needle, compare, start, mid - 1);
  }
}

function viableUsers(to, from) {
  if(! to || ! from) {
    return [];
  }
  var viable = [];
  let compare = (a, b) => a.id - b.id;
  from = from.sort(compare);
  to.forEach(t => {
    if(indexOfBSearch(from, t, compare) !== -1) {
      viable.push(t);
    }
  });
  return viable;
}

class ConversationUserPicker extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      selectedUsers: [],
      possibleUsers: [],
      fetched: false,
      fetching: false,
      nameFilter: ""
    };
  }

  render() {
    let possibleUsers = this.possibleUsers.map((u) => {
      return <PossibleUser
        key={u.id}
        user={u}
        onAdd={this.addUser.bind(this, u)} />;
    });
    let selectedUsers = this.state.selectedUsers.map((u,index) => (
      <SelectedUser
        key={u.id}
        user={u}
        onRemove={this.removeSelected.bind(this, index)} />
    ));
    return <div className="conversation-user-picker">
      <div className="upper">
        <h3>Users</h3>
        <ul className="selected-users-list">
          {selectedUsers}
        </ul>
        <div className="conversation-user-picker-controls">
          <div className="flex-row row-fields">
            <label className="larger-label">
              Name
            </label>
            <input
              value={this.state.nameFilter}
              onChange={this.changeNameFilter.bind(this)} />
          </div>
        </div>
      </div>

      <ul className="possible-users-list">
        {possibleUsers}
      </ul>
    </div>
  }


  get possibleUsers() {
    let selected = this.state.selectedUsers;
    let viable = viableUsers(this.state.subscribers, this.state.subscribed);
    return viable.filter(u => {
      if(u.id === window.CURRENT_USER_ID) {
        return false;
      }
      let i = selected.findIndex(user => user.id === u.id);
      if(i !== -1) {
        return false;
      }
      try {
        var m = new RegExp(this.state.nameFilter, 'i');
        return u.name.match(m);
      }
      catch(err) {
        return true;
      }
    });
  }

  removeSelected(index) {
    let s = this.state.selectedUsers.splice(index, 1);
    this.setState({
      selectedUsers: this.state.selectedUsers
    });
  }

  addUser(user) {
    this.setState({
      selectedUsers: [...this.state.selectedUsers, user]
    });
  }

  changeNameFilter(event) {
    let name = event.target.value;
    this.setState({
      nameFilter: name
    });
  }

  componentDidMount() {
    this.fetchImages();
  }

  async fetchImages() {
    this.fetching = true;

    this.setState({
      fetching: true
    });
    let url = `/users/${window.CURRENT_USER_ID}`;
    let data = await NM.getJSON(url);
    this.setState({
      subscribed: data.subscribed_artists,
      subscribers: data.subscribers,
      fetching: false
    });
    this.fetching = false;
  }
}

window.ConversationUserPicker = ConversationUserPicker;
export default ConversationUserPicker;
