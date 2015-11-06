class TagGroupEditor extends React.Component{
  constructor(props){
    super(props);
    this.state = {
      inputValue: ""
    };
  }

  render(){
    var tags = this.props.tags.map((tag) => {
      return <TagBox tag={tag} onRemove={this.props.onTagRemove} />;
    });
    var suggestions;
    if(this.state.hasSuggestions){
      suggestions = this.state.suggestions.map((sug) => {
        return <li>
          <TagSuggestion tag={sug} onAdd={this.onTagAdd.bind(this)} />
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
      React.findDOMNode(this.refs.groupInput).focus();
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
      }
    }
    // User types an enter key or a comma, try to add the current tag
    else if(event.keyCode == 13 || event.keyCode == 188){
      console.log("Trying to add tag",event.target.value);
      Tag.withPrefix(event.target.value, (tags) => {
        if(tags.length > 0){
          this.props.onTagAdd(tags[0]);
          this.setState({
            hasSuggestions: false,
            inputValue: "",
            hasBlankInput: true,
            lastKeyWasBackspace: false
          });
        }
        else{
          // TODO: Handle this error
          console.log("Attempted to enter an invalid tag");
        }
      });
    }
    else{
      // The last key wasn't a backspace
      this.setState({
        lastKeyWasBackspace: false
      });
    }
  }
  onInputChange(event){
    let value = event.target.value;
    if(event.target.value !== ""){
      Tag.withPrefix(event.target.value, (tags) => {
        if(tags.length > 0){
          // due to react, we have to handle the input's value ourselves
          this.setState({
            hasBlankInput: false,
            hasSuggestions: true,
            suggestions: tags,
            inputValue: value
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
    else{
      this.setState({
        hasBlankInput: true,
        hasSuggestions: false,
        suggestions: [],
        inputValue: ""
      });
    }
  }
}

class TagSuggestion extends React.Component{
  constructor(props){
    super(props);
    this.state = {};
  }
  render(){
    return <div onClick={this.click.bind(this)}>
      Suggestion: {this.props.tag.name}
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
      {this.props.tag.name}
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
