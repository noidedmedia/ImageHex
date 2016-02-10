class MessageListComponent extends React.Component{
  constructor(props){
    super(props);
    this.state = {};
  }

  render(){
    var messages = this.props.messages.map((msg) => {
      return <MessageComponent key={msg.id}
        message={msg} 
        currentUserId={this.props.currentUserId}
        />;
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
    console.group("Checking if we need to fetch older messages...");
    if(this.state.fetchingMessages){
      console.log("We are already fetching messages, stopping check");
      console.groupEnd();
      return;
    }
    var node = ReactDOM.findDOMNode(this);
    console.log("Scrolltop of node:",node.scrollTop);
    if(node.scrollTop < 100 && this.props.hasOlderMessages()){
      console.log("Older message fetch needed. Starting now");
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
      console.log("Older message fetch is not needed.");
    }
    console.groupEnd();
  }


}
