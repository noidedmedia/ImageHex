class ElsewhereEditor extends React.Component {
  constructor(props){
    console.log("In ElsewhereEditor, got props:",props);
    super(props);
    if(props.current instanceof Array){
      this.state = {
        items: props.current
      };
    }
    else{
      this.state = {
        items: []
      };
    }
  }
  render(){
    var items = this.state.items.map((item, index) => {
      return <ElsewhereItem item={item}
        index={index}
        key={index}
        onRemove={this.removeItem.bind(this, item)} />;
    });
    return <div className="elsewhere-editor">
      <h1>Elsewhere</h1>
      <ul id="elsewhere-editor-items">
        {items}
      </ul>
      <input type="text" 
        value={this.state.inputValue}
        onChange={this.changeInput.bind(this)}></input>
      <button onClick={this.addItem.bind(this)}>
        Add Item
      </button>
    </div>
  }
  changeInput(event){
    this.setState({
      inputValue: event.target.value
    });
  }
  removeItem(item){
    this.state.items.splice(this.state.items.indexOf(item, 1));
    this.setState({
      items: this.state.items
    });
  }
  addItem(event){
    event.preventDefault();
    this.state.items.push(this.state.inputValue);
    this.setState({
      items: this.state.items,
      inputValue: ""
    });
  }
}

class ElsewhereItem extends React.Component{
  constructor(props){
    super(props);
    this.state = {
      item: this.fixItem()
    };
  }

  fixItem(){
    var i = this.props.item;
    if(i.startsWith("http://") || i.startsWith("https://")){
      return i;
    }
    else{
      return "https://" + i;
    }
  }

  render(){
    return <li className="elsewhere-editor-item">
      <a href={this.state.item} target="_blank">
        {this.getName()}
      </a>
      <span onClick={this.props.onRemove}>remove</span>
      <input type="hidden" value={this.state.item} name="user[elsewhere][]" />
    </li>;
  }

  getName(){
    var tag = document.createElement('a');
    tag.href = this.state.item;
    console.log("Got hostname",tag.host);
    return tag.host;
  }

}
