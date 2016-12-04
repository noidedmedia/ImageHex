import React from 'react';
import Tag from '../../api/tag.es6';
import InlineTagCreator from './inline_tag_creator.es6.jsx';
import GroupTag from './group_tag.es6.jsx';
import TagSuggestion from './tag_suggestion.es6.jsx';

/**
 * Display an interface for editing tag groups.
 * Doesn't manage any state relating to an actual group, so you have to wrap
 * it in something. This is to make it easier to use in various situations.
 */
class TagGroupEditor extends React.Component {
  /**
   * See TagGroupEditor.propTypes
   */
  constructor(props) {
    super(props);
    this.state = {
      inputValue: "",
      activeSuggestion: undefined,
      hasBlankInput: true,
      isActive: false
    }  
  }

  render() {
    // A list of all tags in this group currently
    var tags = this.props.tags
    .sort((a, b) => b.importance - a.importance)
    .map((tag) => (
      <GroupTag
        key={tag.id}
        tag={tag}
        removeSelf={this.props.onTagRemove.bind(null, tag)} />));
    var suggestions = this.suggestions;
    var inputField = <input
      className="tag-group-editor-input"
      id={this.inputId}
      name="suggestions" 
      onChange={this.onInputChange.bind(this)}
      onKeyDown={this.onKeyUp.bind(this)}
      value={this.state.inputValue}
      ref={(n) => this._groupInput = n}
      placeholder={this.inputPlaceholder}
    />;
    var inputSection;
    if (this.props.isHeaderSearch) {
      inputSection = <div className="search-outer-container">
        <label title="Search" htmlFor="search-input">
          <span className="icon icon-small icon-search"></span>
        </label>
        <span className="search-input-container">
          {inputField}
          {this.goButton}
        </span>
      </div>;
    }
    else {
      inputSection = inputField;
    }
    return <div className="tag-group-editor">
      <ul className="tag-group-editor-tags">
        {tags}
      </ul>
      {inputSection}
      <ul className="tag-group-editor-tags-suggestions">
        {suggestions}
      </ul>
      {this.inlineCreator}
    </div>;
  }


  get inlineCreator() {
    if (!this.state.hasBlankInput && this.props.allowTagCreation) {
      return <InlineTagCreator 
        hideSubmit={this.props.hideSubmit}
        onAdd={this.onTagAdd.bind(this)}
        initialTagName={this.state.inputValue} />;
    }
    else {
      return "";
    }
  }

  get goButton() {
    if (this.state.isActive) {
      // Golly gee I love centering stuff in CSS
      return <span className="search-side-button"
        onClick={this.props.submit}>
        <span>Go</span>
      </span>;
    }

    console.log("Go button is not a go ;-;");
    return "";
  }

  get inputPlaceholder() {
    return this.props.isHeaderSearch ? "Search" : "Add a Tag";
  }

  get inputId() {
    return this.props.isHeaderSearch ? "search-input" : "";
  }

  get suggestions() {
    if (this.state.hasSuggestions) {
      // Show the suggestions if we have any
      return this.state.suggestions.map((sug, index) => (
        <TagSuggestion
          key={sug.id}
          tag={sug}
          isActive={index == this.state.activeSuggestion} 
          addSelf={this.onTagAdd.bind(this, sug)} />
      ));

    }
    // Now, if we do want to show the user suggestions, display a notification
    // that there aren't any to show.
    else if (this.state.showSuggestions) {
      return <li className="imagehex-empty-note">
        Found no suggestions.
      </li>;
    }
    // Sometimes we don't even want to let the user know that we don't have
    // any suggestions. This is mostly for the case where the input is blank,
    // and can probably be refactored out.
    else {
      return "";
    }
  }
  /**
   * Tell our parent that we are adding a tag, and do our own bookkeeping.
   * Notably, we clear suggestions and our input field.
   */
  onTagAdd(tag) {
    this.props.onTagAdd(tag);
    this.setState({
      hasSuggestions: false,
      showSuggestions: false,
      inputValue: "",
      hasBlankInput: true
    });
  }


  /**
   * Watch for a backspace in a blank box, which automatically removes the
   * previously-added tag and puts its name in the box. 
   *
   * This feature exists so that you can easily correct your mistake if you
   * accidentally click the wrong tag in suggestions.
   */
  onKeyUp(event) {
    // Input is currently blank, but that may be because we deleted the last
    // character in the box
    if (this.state.hasBlankInput && event.keyCode == 8) {
    }
    // User types an enter key or a comma, try to add the current tag
    else if (event.keyCode == 13) {
      // this is where things get a bit complicated
      // if we have are pressing shift, or hitting enter in a blank box...
      if (event.shiftKey || event.target.value === "") {
        // Add the current suggestion if we have it
        if (event.target.value !== "") {
          this.addActive();
        }
        // And always submit
        this.props.submit();
      }
      // Now, if we aren't pressing the shift key... 
      else {
        this.addActive();
      }
      event.preventDefault();
    }
    else if (event.keyCode == 188) {
      this.addActive();
    }
    // down arrow
    else if (event.keyCode == 40) {
      // Don't move to a suggestion we don't have
      var newSuggestion = Math.min(this.state.suggestions.length - 1,
                                   this.state.activeSuggestion + 1);
      // don't jump around inside the text box
      event.preventDefault();
      console.log("Changing active selection to", newSuggestion);
      this.setState({
        activeSuggestion: newSuggestion,
        lastKeyWasBackspace: false
      });
    }
    // up arrow
    else if (event.keyCode == 38) {
      // by default up takes you to the start of the text box
      // stop that from happening
      event.preventDefault();
      // Don't move to a suggestion we don't have
      var newSuggestion = Math.max(0,
                                   this.state.activeSuggestion - 1);
      this.setState({
        activeSuggestion: newSuggestion,
        lastKeyWasBackspace: false
      });
    }
    // The last key wasn't a backspace

  }

  backspacePressed() {
    // if it as blank and the key we pressed before this was also a backspace
    // we have pressed backspace in a blank box and thus should go to the
    // previous tag
    if (this.state.lastKeyWasBackspace) {
      let lastTag = this.props.tags[this.props.tags.length - 1];
      this.props.onTagRemove(lastTag);
      this.setState({
        hasBlankInput: false,
        inputValue: lastTag.name
      });
    }
    // Tf the last key wasn't a backspace, this backspace made the box blank.
    // That means that the next backspace should go to the previous tag.
    else {
      this.setState({
        lastKeyWasBackspace: true
      });
    }
  }


  /**
   * Add the active suggestion.
   */
  addActive() {
    if (this.state.activeSuggestion !== undefined) {
      var tag = this.state.suggestions[this.state.activeSuggestion];
      this.onTagAdd(tag);
    } else {
      // TODO: Handle this error, even though it should never happen.
    }
  }

  /**
   * Handle each time the input updates, fetching new suggestions each time,
   * or doing other actions in certain cases.
   */
  onInputChange(event) { 
    var value = event.target.value;
    if (event.target.value !== "") {
      this.fetchSuggestions(event.target.value);
      this.setState({
        inputValue: event.target.value
      });
    } 
    else {
      if(this.props.showSubmit){
        this.props.showSubmit();
      }
      this.setState({
        hasBlankInput: true,
        hasSuggestions: false,
        showSuggestions: false,
        suggestions: [],
        inputValue: ""
      });
    }
  }

  /**
   * Start fetching new suggestions. 
   * See `onInputChange` for info on how we may refactor this.
   */
  async fetchSuggestions(value) {
    let tags = await Tag.withPrefix(value, value.length > 1);
    let filtered = tags.filter((tag) => {
      return ! this.props.tags.some(t => t.id == tag.id);
    });
    if(filtered.length > 0) {
      /**
       * We also set the `active` suggestion to 0. This may result in weird
       * behavior if the user hits the down arrow key to change the active
       * suggestion, then types another character. However, if the user is 
       * hitting the down arrow to change their active selection, it stands
       * to reason that they will just hit "enter" to select that and not
       * keep typing. After all, why switch the active suggestion if you need
       * to keep typing? If it becomes a problem we can fix it, but for
       * right now this should work.
       */
      this.setState({
        hasBlankInput: false,
        hasSuggestions: true,
        showSuggestions: true,
        suggestions: filtered,
        activeSuggestion: 0
      });
    }
    else {
      this.setState({
        hasSuggestions: false,
        showSuggestions: true,
        hasBlankInput: false,
      });
    }
  }
}

TagGroupEditor.propTypes = {
  // Should we display a tag creator?
  // Typically only true if we are editing a tag group
  allowTagCreation: React.PropTypes.bool,
  // This is either a tag group or an EtherealTagGroup
  // EtherealTagGroups quack like TagGroups for the purposes of this
  // component. Commented out for now because these JS files aren't being
  // loaded in the proper order, so this errors out. We can probably fix that
  // using ES6 require at some point.
  /* 
     group: React.PropTypes.oneOfType([
     React.PropTypes.instanceOf(TagGroup),
     React.PropTypes.instanceOf(EtherealTagGroup)
     ]),
     */
  // Autofocus this editor's input when we have new suggestions if true
  autofocus: React.PropTypes.bool,
  // A function called when an InlineTagEditor wants to hide the form's 
  // submit button. Mostly used when creating or editing tag groups, since we
  // wrap that in another component.
  //
  // Should probably be renamed, to be honest.
  hideSubmit: React.PropTypes.func,
  // Same as the above, but alerts the parent that they should show the submit
  // button again.
  showSubmit: React.PropTypes.func,
  // We don't handle any of the group's state, instead passing everything up
  // to the parent. This callback is called with a `tag` option when the
  // user adds a new tag to this group.
  onTagAdd: React.PropTypes.func,
  // Same as the above, but intended to be used for removal.
  onTagRemove: React.PropTypes.func,
  // The tags in this group
  // We could get that from the group object, come to think of it.
  // Maybe refactor this out.
  //
  // Commented out for now because the JS files are not required in the right
  // order. Maybe use ES6 modules to fix?
  // tags: React.PropTypes.arrayOf(React.PropTypes.instanceOf(Tag)),
  // Should we allow this tag group to self-destruct? 
  // Useful in contexts in which we edit more than one group.
  // 
  // Should maybe be refactored into some kind of "removable" component, which
  // would wrap this TagGroupEditor (and all the other things we can remove) and
  // show a little X in the corner. Not really sure.
  allowRemoval: React.PropTypes.bool,
  // We call this when the user clicks our `remove` button.
  //
  // See above for a way to refactor this.
  onRemove: React.PropTypes.func
};

export default TagGroupEditor;
