import NM from '../../api/global.es6';
import 'babel-polyfill';
import Comment from './comment.es6.jsx';

class CommentsView extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      currentPage: 0,
      fetching: false,
      isVisible: false,
      comments: []
    }
  }
  render() {
    console.log(this);
    if(! this.state.isVisible || ! this.state.comments) {
      return <div ref={(r) => this.overallContainer = r}>
        </div>;
    }
    if(this.state.fetching) {
      return <div>
        <progress></progress>
      </div>;
    }

    var cmts = this.state.comments.map((c) => <Comment {...c} key={c.id} />);
    return <div>
      {cmts}
    </div>;
  }

  componentDidMount() {
    console.log("Adding a scroll handler");
    $("body").on("scroll.comments", (event) => {
      var r = $(this.overallContainer)[0].getBoundingClientRect();
      if(r.bottom <= window.innerHeight && ! this.state.fetching) {
        this.setState({
          currentPage: 1,
          isVisible: true
        });
        $("body").off("scroll.comments");
        this.fetchCurrent();
      }
    });
  }

  async fetchCurrent() {
    if(this.state.fetching) {
      return;
    }
    this.setState({
      fetching: true
    });
    let url = this.props.url + `.json?page=${this.state.currentPage}`;
    console.log("Url is ",url);
    var res = await NM.getJSON(url);
    console.log("Got comments from fetch",res);
    this.setState({
      comments: res.comments,
      totalPages: res.total_pages,
      fetching: false
    });
  }
}

$(document).on("page:change", function() {
  var box = $(".comments-container");
  if(box.length === 0) {
    console.log("Length zero, returning.");
    return;
  }
  ReactDOM.render(<CommentsView
    url={box.data("url")} />, box[0]);
});
