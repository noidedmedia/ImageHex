class TagGroupEditor extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      inputValue: "",
      activeSuggestion: undefined,
      hasBlankInput: true
    };
  }

  render() {
    var tags = this.props.tags.map((tag) => {
      return <TagBox tag={tag} 
        onRemove={this.props.onTagRemove} 
        key={tag.id}
      />;
    });
    var suggestions;
    if (this.state.hasSuggestions) {
      console.log("Rendering suggestions",this.state.suggestions);
      suggestions = this.state.suggestions.map((sug, index) => {
        return <TagSuggestion
          key={"tag-" + sug.id}
          tag={sug}
          isActive={index == this.state.activeSuggestion} 
          onAdd={this.onTagAdd.bind(this)} />
      });
    }
    else if (!this.state.hasBlankInput && this.props.allowTagCreation) {
      console.log("Rendering an inline tag creator");
      suggestions = <InlineTagCreator 
        hideSubmit={this.props.hideSubmit}
        onAdd={this.onTagAdd.bind(this)}
        tagName={this.state.inputValue} />;
    }
    else if (this.state.showSuggestions) {
      suggestions = <li className="imagehex-empty-note">
        Found no suggestions.
      </li>;
    }
    else {
      console.log("No suggestions to show and no reason to tell the user");
      suggestions = "";
    }
    
    var removalButton;
    if (this.props.allowRemoval) {
      removalButton = <div className="remove-tag-group"
        onClick={this.props.onRemove}>
        Remove
      </div>
    } else {
      removalButton = <div></div>;
    }

    var inputField;
    if (this.props.isSearch) {
      inputField = <div>
        <label title="Search" htmlFor="search-input">
          <span className="icon icon-small icon-search"></span>
        </label>
        <input type="text" 
          id="search-input"
          name="suggestions" 
          onChange={this.onInputChange.bind(this)}
          onKeyDown={this.onKeyUp.bind(this)}
          value={this.state.inputValue}
          ref="groupInput"
          placeholder="Search"
        />
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
    </div>;
  }

  componentDidUpdate() {
    if (this.props.autofocus) {
      ReactDOM.findDOMNode(this.refs.groupInput).focus();
    }
  }

  onTagAdd(tag) {
    this.props.onTagAdd(tag);
    this.setState({
      hasSuggestions: false,
      showSuggestions: false,
      inputValue: "",
      hasBlankInput: true
    });
  }


  // Watch for a backspace in a blank box, which automatically fills the box
  // with the value of the last tag.
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

  // Probably should be called "addActiveSuggestion"
  addActive() {
    if (this.state.activeSuggestion !== undefined) {
      var tag = this.state.suggestions[this.state.activeSuggestion];
      this.onTagAdd(tag);
      this.setState({
        suggestions: [],
        hasSuggestions: false,
        showSuggestions: false,
        lastKeyWasBackspace: false
      });
    } else {
      // TODO: Handle this error ;-;
    }
  }

  onInputChange(event){ 
    let value = event.target.value;
    if (event.target.value !== "") {
      this.fetchSuggestions(event.target.value);
      this.setState({
        inputValue: event.target.value
      });
    } else {
      this.setState({
        hasBlankInput: true,
        hasSuggestions: false,
        showSuggestions: false,
        suggestions: [],
        inputValue: ""
      });
    }
  }

  fetchSuggestions(value) {
    Tag.withPrefix(value, (tags) => {
      if (tags.length > 0) {
        var ntags = tags.filter( (tag) => {
          for (var i = 0; i < this.props.tags.length; i++) {
            if (this.props.tags[i].id === tag.id) {
              console.log("Tag named " + tag.name + " already in list");
              console.log(tags);
              console.log("Removing it from the suggestion list");
              return false;
            }
          }
          return true;
        });
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
          suggestions: ntags,
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
    });
  }
}

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
