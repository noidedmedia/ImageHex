import React from 'react';
import DashboardItem from './dashboard_item';
import NM from '../../api/global.es6';
import ReactUJS from '../../react_ujs';
import TransitionGroup from 'react-addons-css-transition-group';
import Store from './dashboard_store';

const FollowStuffMessage = () => (
  <div id="follow-stuff-message">
    <span>There isn't anything here. </span>
    <span>Follow some <a href="/users">artists</a> </span>
    <span>or <a href="/collections">collections</a> to fix that.</span>
  </div>
);

class Dashboard extends React.Component {
  constructor(props) {
    super(props);
    this.store = new Store(props);
    this.state = this.store.getState();
    this.store.setChangeListener(state => this.setState(state));
  }

  render() {
    var items = this.state.items.map((item) => {
      return <DashboardItem item={item} key={`${item.type}:${item.id}`} />;
    });
    var fetchBar = <div></div>;
    let overallClass = "";
    if(this.state.fetching) {
      overallClass = "swirly-background";
    }
    else if(! this.state.hasFurther) {
      fetchBar = <div>
        No more images
      </div>;
    }
    return <div className={overallClass}>
      <ul className="frontpage-subscription-container"
        ref={(r) => this.listContainer = r}>
        <TransitionGroup
          transitionName="frontpage-slide"
          transitionEnterTimeout={500}
          transitionLeaveTimeout={500}>
          {items}
        </TransitionGroup>
      </ul>
      {fetchBar}
    </div>;
  }
}

ReactUJS.register("Dashboard", Dashboard);

export default Dashboard;
