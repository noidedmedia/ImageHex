class TagGroupEditor extends React.Component{
  constructor(props){
    super(props);
    this.state = {
      inputValue: "",
      activeSuggestion: undefined
    };
  }

  render(){
    var tags = this.props.tags.map((tag) => {
      return <TagBox tag={tag} onRemove={this.props.onTagRemove} />;
    });
    var suggestions;
    if(this.state.hasSuggestions){
      suggestions = this.state.suggestions.map((sug, index) => {
        return <li>
          <TagSuggestion tag={sug}
            isActive={index == this.state.activeSuggestion} 
            onAdd={this.onTagAdd.bind(this)} />
        </li>;
      });
    }
    else{
      suggestions = <li className="no-suggestions"> 
        No Suggestions Found.
      </li>;
    }
    return <div className="tag-group-editor">
      <ul className="tag-group-editor-tags">
        {tags}
      </ul>
      <input type="text" 
        name="suggestions" 
        onInput={this.onInputChange.bind(this)}
        onKeyUp={this.onKeyUp.bind(this)}
        value={this.state.inputValue}
        ref="groupInput"
      />
      <ul className="tag-group-editor-tags-suggestions">
        {suggestions}
      </ul>
    </div>;
  }
  componentDidUpdate(){
    if(this.props.autofocus){
      console.log("Focusing a Tag Group");
      ReactDOM.findDOMNode(this.refs.groupInput).focus();
    }
    else{
      console.log("Not focusing this tag group");
    }
  }
  onTagAdd(tag){
    this.props.onTagAdd(tag);
    this.setState({
      hasSuggestions: false,
      inputValue: "",
      hasBlankInput: true
    });
  }
  // Watch for a backspace in a blank box, which automatically fills the box
  // with the value of the last tag.
  onKeyUp(event){
    // Input is currently blank, but that may be because we deleted the last
    // character in the box
    if(this.state.hasBlankInput && event.keyCode == 8){
      // if it as blank and the key we pressed before this was also a backspace
      // we have pressed backspace in a blank box and thus should go to the
      // previous tag
      if(this.state.lastKeyWasBackspace){
        let lastTag = this.props.tags[this.props.tags.length - 1];
        this.props.onTagRemove(lastTag);
        this.setState({
          hasBlankInput: false,
          inputValue: lastTag.name
        });
      }
      // Tf the last key wasn't a backspace, this backspace made the box blank.
      // That means that the next backspace should go to the previous tag.
      else{
        this.setState({
          lastKeyWasBackspace: true
        });
        return;
      }
    }
    // User types an enter key or a comma, try to add the current tag
    else if(event.keyCode == 13){
      // this is where things get a bit complicated
      // if we have are pressing shift...
      if(event.shiftKey){
        // ...and a non-blank box, add the active suggestion
        if(event.target.value !== ""){
          this.addActive();
        }
        // And always submit
        this.props.submit();
      }
      // Now, if we aren't pressing the shift key, just add the active tag
      else{
        this.addActive();
      }
    }
    else if(event.keyCode == 188){
      this.addActive();
    }
    // down arrow
    else if(event.keyCode == 40){
      // Don't move to a suggestion we don't have
        var newSuggestion = Math.min(this.state.suggestions.length - 1,
          this.state.activeSuggestion + 1);
        // don't jump around inside the text box
        event.preventDefault();
        console.log("Changing active selection to", newSuggestion);
        this.setState({
          activeSuggestion: newSuggestion
        });
    }
    // up arrow
    else if(event.keyCode == 38){
      // by default up takes you to the start of the text box
      // stop that from happening
      event.preventDefault();
      // Don't move to a suggestion we don't have
      var newSuggestion = Math.max(0,
        this.state.activeSuggestion - 1);
      this.setState({
        activeSuggestion: newSuggestion
      });
    }
    // The last key wasn't a backspace
    this.setState({
      lastKeyWasBackspace: false
    });
  }

  // Probbly should be called "addActiveSuggestion"
  addActive(){
    if(this.state.activeSuggestion !== undefined){
      var tag = this.state.suggestions[this.state.activeSuggestion];
      this.onTagAdd(tag);
      this.setState({
        suggestions: [],
        hasSuggestions: false
      });
    }
    else{
      // TODO: Handle this error ;-;
    }
  }
  onInputChange(event){
    let value = event.target.value;
    if(event.target.value !== ""){
      this.fetchSuggestions(event.target.value);
    }
    else{
      this.setState({
        hasBlankInput: true,
        hasSuggestions: false,
        suggestions: [],
        inputValue: ""
      });
    }
  }
  fetchSuggestions(value){
    Tag.withPrefix(value, (tags) => {
      if(tags.length > 0){
        /**
         * We have to set the input value ourselves due to the input
         * being a managed react component.
         *
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
          suggestions: tags,
          inputValue: value,
          activeSuggestion: 0
        });
      }
      else{
        this.setState({
          hasSuggestions: false,
          hasBlankInput: false,
          suggestions: [],
          inputValue: value
        });
      }
    });
  }
}

class TagSuggestion extends React.Component{
  constructor(props){
    super(props);
    this.state = {};
  }
  render(){
    var className = "tag-group-tag-suggestion";
    if(this.props.isActive){
      className += " active";
    }
    return <div 
      className={className}
      onClick={this.click.bind(this) }>
      Suggestion: {this.props.tag.display_name}
    </div>;
  }
  click(){
    this.props.onAdd(this.props.tag);
  }
}

class TagBox extends React.Component{
  constructor(props){
    super(props);
    this.state = {};
  }
  render(){
    return <div>
      {this.props.tag.display_name}
      <div className="tag-box-remove-tag"
        onClick={this.removeSelf.bind(this)}>
        Remove
      </div>
    </div>;
  }
  removeSelf(){
    this.props.onRemove(this.props.tag);
  }
}
