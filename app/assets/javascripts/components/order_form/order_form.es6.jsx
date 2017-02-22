import React from 'react';
import GroupRemovalFields from './group_removal_fields';
import ReferenceGroupForm from './reference_group_form';
import ReactUJS from '../../react_ujs';
import TransitionGroup from 'react-addons-css-transition-group';

class OrderForm extends React.Component {
  constructor(props) {
    super(props);
    let groups = props.groups ? props.groups : [{id: -1}];
    this.state = {
      groups: groups,
      removedGroupIds: []
    };
    this.refKey = -2;
  }

  render() {
    let groups = this.state.groups.map((rg, idx) => {
      let baseFieldName = `order[groups_attributes][${idx}]`;
      return <ReferenceGroupForm
        key={rg.id}
        baseFieldName={baseFieldName}
        group={rg}
        removeSelf={this.removeGroup.bind(this, idx)} />;
    });
    let startIndex = this.state.groups.length;
    let removed = this.state.removedGroupIds.map((id, idx) => {
      return <GroupRemovalFields id={id} index={startIndex + idx} key={id} />;
    });
    return <div>
      <ul className="reference-group-form-list">
        <TransitionGroup
          transitionName="order-slide"
          transitionEnterTimeout={500}
          transitionLeaveTimeout={500}>
          {groups}
        </TransitionGroup>
      </ul>
      <button className="btn btn-green btn-add add-group-button"
        onClick={this.addGroup.bind(this)}>
        Add Reference Group
      </button>
      {removed}
      <div className="order-form-footer">
        {this.submitButton()}
      </div>
    </div>
  }

  submitButton() {
    if(this.state.groups.length > 0) {
      return <button 
        type="submit"
        className="btn btn-green btn-check">
        Submit
      </button>;
    }
    return <button
      disabled="true">
      Add some reference material to submit
    </button>;
  }

  removeGroup(index) {
    let dup = this.state.groups.slice();
    let removed = dup.splice(index, 1)[0];
    let rgi = this.state.removedGroupIds;
    if(removed.id > 0) {
      rgi = [...rgi, removed.id];
    }
    this.setState({
      groups: dup,
      removedGroupIds: rgi
    });
  }

  addGroup(event) {
    event.preventDefault();
    this.setState({
      groups: [...this.state.groups, {id: this.refKey--}]
    });
  }
}

ReactUJS.register("OrderForm",OrderForm);
export default OrderForm;
