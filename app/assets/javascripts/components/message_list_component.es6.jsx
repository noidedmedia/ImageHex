class MessageListComponent extends React.Component{
  constructor(props){
    super(props);
    this.state = {}
  }
  render(){
    var messages = this.props.messages.map((msg) => {
      return <MessageComponent key={msg.id}
        message={msg} />;
    });
    return <ul className="conversation-message-list"
      onScroll={this.scrollMessages.bind(this)}>
      {messages}
    </ul>;
  }

  componentDidMount(){
    window.requestAnimationFrame(() => {
      var node = ReactDOM.findDOMNode(this);
      // keep scrolled to bottom initially
      node.scrollTop = node.scrollHeight;
      this.checkForOlderMessageFetch();
    });
  }

  componentWillUpdate(){
    var node = ReactDOM.findDOMNode(this);
    var h = node.scrollTop + node.offsetHeigh;
    this.shouldScrollBottom = h === node.scrollHeight;
    this.scrollHeight = node.scrollHeight;
    this.scrollTop = node.scrollTop;
  }
  componentDidUpdate(){
    var node = ReactDOM.findDOMNode(this);
    if(this.shouldScrollBottom){
      node.scrollTop = node.scrollHeight;
    }
    else{
      node.scrollTop = this.scrollTop + (node.scrollHeight - this.scrollHeight);
    }
    window.requestAnimationFrame(() => {
      this.checkForOlderMessageFetch();
    });
  }

  scrollMessages(event){
    console.log("Scrolling messages");
    this.checkForOlderMessageFetch();
  }

  checkForOlderMessageFetch(){
    if(this.state.fetchingMessages){
      console.log("We are already fetching messages, stopping check");
      return;
    }
    var node = ReactDOM.findDOMNode(this);
    console.log("Scrolltop of node:",node.scrollTop);
    if(node.scrollTop < 100 && this.props.hasOlderMessages()){
      console.log("Fetching older messages...");
      this.props.fetchOlderMessages(() => {
        this.setState({
          fetchingMessages: false
        });
      });
      // Prevent fetching messages twice 
      this.setState({
        fetchingMessages: true,
        scrollPosition: node.scrollHeight - node.scrollTop
      });
    } 
    else{
      console.log("No reason to get other messages");
    }
  }
}
