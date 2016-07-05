import NM from '../api/global.es6';


const UserInfo = (user) => (
  <div className="user-info flex-row">
    <img src={user.avatar_img_thumb} />
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
            {this.pagination}
        </div>
      </div>

      <ul className="possible-users-list">
        {possibleUsers}
      </ul>
    </div>
  }

  get pagination() {
    let left = <div></div>;
    if(this.state.currentPage > 1) {
      left = <a
        className="control-button previous-button"
        onClick={this.regressPage.bind(this)}>
        ←
      </a>;
    }
    let right = <div></div>;
    if(this.state.currentPage < this.state.totalPages) {
      right = <a
        className="control-button next-button"
        onClick={this.advancePage.bind(this)}>
        →
      </a>;
    }
    return <div className="flex-row pagination-controls">
      {left}
      {right}
    </div>;
  }

  advancePage() {
    this.setState({
      currentPage: this.state.currentPage + 1
    }, () => this.fetchImages());
  }

  regressPage() {
    this.setState({
      currentPage: this.state.currentPage - 1
    }, () => this.fetchImages());
  }

  get possibleUsers() {
    let selected = this.state.selectedUsers;
    return this.state.possibleUsers.filter(u => {
      if(u.id === window.CURRENT_USER_ID) {
        return false;
      }
      let i = selected.findIndex(user => user.id === u.id);
      return i === -1;
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
    // Update if the user hasn't typed after a certain delay
    window.setTimeout(() => {
      if(this.state.nameFilter === name &&
                      ! this.fetching) {
        this.fetchImages();
      }
    }, 500);
  }

  componentDidMount() {
    this.fetchImages();
  }

  async fetchImages() {
    this.fetching = true;

    this.setState({
      fetching: true
    });
    let params = this.formParams;
    let url = `/users/search?`;
    url += $.param(params);
    let data = await NM.getJSON(url);
    this.setState({
      possibleUsers: data.users,
      currentPage: data.page,
      totalPages: data.total_pages,
      fetching: false
    });

    this.fetching = false;
  }

  get formParams() {
    return {
      page: this.state.currentPage || 1,
      name: this.state.nameFilter,
      unblocked_by: window.CURRENT_USER_ID
    };
  }
}

window.ConversationUserPicker = ConversationUserPicker;
export default ConversationUserPicker;
