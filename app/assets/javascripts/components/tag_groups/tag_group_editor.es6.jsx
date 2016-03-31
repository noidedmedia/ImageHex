import Tag from '../../api/tag.es6';
import InlineTagCreator from './inline_tag_creator.es6.jsx';
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
    };
  }

  render() {
    // A list of all tags in this group currently
    var tags = this.props.tags.map((tag) => {
      return <TagBox tag={tag} 
        onRemove={this.props.onTagRemove} 
        key={tag.id}
      />;
    });
    var suggestions;
    if (this.state.hasSuggestions) {
      // Show the suggestions if we have any
      suggestions = this.state.suggestions.map((sug, index) => {
        return <TagSuggestion
          key={"tag-" + sug.id}
          tag={sug}
          isActive={index == this.state.activeSuggestion} 
          onAdd={this.onTagAdd.bind(this)} />;
      });

    }
    // Now, if we do want to show the user suggestions, display a notification
    // that there aren't any to show.
    else if (this.state.showSuggestions) {
      suggestions = <li className="imagehex-empty-note">
        Found no suggestions.
      </li>;
    }
    // Sometimes we don't even want to let the user know that we don't have
    // any suggestions. This is mostly for the case where the input is blank,
    // and can probably be refactored out.
    else {
      suggestions = "";
    }

    var inlineCreator = "";
    if (!this.state.hasBlankInput && this.props.allowTagCreation) {
      inlineCreator = <InlineTagCreator 
        hideSubmit={this.props.hideSubmit}
        onAdd={this.onTagAdd.bind(this)}
        initialTagName={this.state.inputValue} />;

    }
    var removalButton = "";
    // If we allow removal, add a button to do so.
    if (this.props.allowRemoval) {
      removalButton = <div className="remove-tag-group"
        onClick={this.props.onRemove}>
        Remove
      </div>;
    }
    // Determine how the input field is going to look
    // Used for styling purposes.
    var inputField;
    if (this.props.isHeaderSearch) {
      var goButton = "";
      if (this.state.isActive) {
        // Golly gee I love centering stuff in CSS
        goButton = <span className="search-side-button"
          onClick={this.props.submit}>
          <span>Go</span>
        </span>;
      }
      inputField = <div className="search-outer-container">
        <label title="Search" htmlFor="search-input">
          <span className="icon icon-small icon-search"></span>
        </label>
        <span className="search-input-container">
          <input type="text" 
            id="search-input"
            name="suggestions" 
            onChange={this.onInputChange.bind(this)}
            onKeyDown={this.onKeyUp.bind(this)}
            value={this.state.inputValue}
            ref="groupInput"
            placeholder="Search"
            onFocus={this.focus.bind(this)}
          />
          {goButton}
        </span>
      </div>;
    } else {
      inputField = <input type="text" 
        name="suggestions" 
        onChange={this.onInputChange.bind(this)}
        onKeyDown={this.onKeyUp.bind(this)}
        value={this.state.inputValue}
        ref="groupInput"
      />;
    }

    return <div className="tag-group-editor">
      {removalButton}
      <ul className="tag-group-editor-tags">
        {tags}
      </ul>
      {inputField}
      <ul className="tag-group-editor-tags-suggestions">
        {suggestions}
      </ul>
      {inlineCreator}
    </div>;
  }
  /**
   * Focus our text box on every update, if props tells us to.
   * Otherwise, the user has to click in the box again.
   */
  componentDidUpdate() {
    if (this.props.autofocus) {
      ReactDOM.findDOMNode(this.refs.groupInput).focus();
    }
  }

  focus() {
    this.setState({isActive: true});
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
        return;
      }
      // Tf the last key wasn't a backspace, this backspace made the box blank.
      // That means that the next backspace should go to the previous tag.
      else {
        this.setState({
          lastKeyWasBackspace: true
        });
        return;
      }
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
   *
   * This should almost certainly be modified to only fetch new suggestions for
   * the first 3-4 characters, and to filter the existing suggestions from that
   * point on. Right now, though, we're 2agile4that, or something.
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
  fetchSuggestions(value) {
    Tag.withPrefix(value, (tags) => {
      // Filter tags already in this group
      tags = tags.filter( (tag) => {
        for (var i = 0; i < this.props.tags.length; i++) {
          if (this.props.tags[i].id === tag.id) {
            return false;
          }
        }
        return true;
      });
      if (tags.length > 0) {

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
          suggestions: tags,
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
    }, value.length > 1);
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

/**
 * A very simple display of a tag suggestion
 */
class TagSuggestion extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    var className = "tag-group-tag-suggestion";
    if (this.props.isActive) {
      className += " active";
    }
    return <li
      className={className}
      onClick={this.click.bind(this)}>
      <span>{this.props.tag.name}</span>
    </li>;
  }
  click() {
    this.props.onAdd(this.props.tag);
  }
}

TagSuggestion.propTypes = {
  // The tag we are suggesting. Commented out for now because our JS
  // is loading in the wrong order, so this isn't visible
  // tag: React.PropTypes.instanceOf(Tag),
  // Is this the active suggestion?
  active: React.PropTypes.bool,
  // Call this callback with our tag if somebody clicks on us
  onTagAdd: React.PropTypes.func
};



/**
 * Box one tag value, displaying it in this group and allowing user removal.
 * 
 * Should almost definitely be renamed.
 */
class TagBox extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    return <li className="tag-box-added-tag">
      {this.props.tag.name}
      <div className="tag-box-remove-tag"
        onClick={this.removeSelf.bind(this)}>
        Remove
      </div>
    </li>;
  }

  removeSelf() {
    this.props.onRemove(this.props.tag);
  }
}

TagBox.propTypes = {
  // The tag we are displaying 
  //  Commented our for now due to JS load order weirdness
  // tag: React.PropTypes.instanceOf(Tag),
  // Call this function when the user clicks our `remove` button
  onRemove: React.PropTypes.func
};

export default TagGroupEditor;
