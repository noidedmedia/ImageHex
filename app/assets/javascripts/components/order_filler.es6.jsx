import ImagePicker from './image_picker/image_picker.es6.jsx';
import NM from '../api/global.es6';

class OrderFiller extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      page: 1,
      selectedImages: [],
      activeImages: []
    };
  }

  render() {
    return <div>
      <ImagePicker
        imageCollection={this.state.activeImages}
        selectedImages={this.state.selectedImages}
        changeSelected={this.changeSelected.bind(this)} />
      {this.submitButton}
    </div>;
  }

  changeSelected(newSelected) {
    let ns = newSelected[newSelected.length - 1];
    this.setState({
      selectedImages: [ns]
    });
  }

  componentDidMount() {
    this.fetchImages();
  }

  async fetchImages() {
    this.setState({
      fetching: true
    });
    let { page } = this.state;
    let id = window.CURRENT_USER_ID;
    let date = new Date(this.props.chargeTime);
    let url = `/users/${id}/creations.json?page=${page}`;
    url += `&created_after=${date.getTime() / 1000}`;
    console.log("Fetching with url",url);
    let resp = await NM.getJSON(url);
    this.setState({
      activeImages: resp.images,
      fetching: false,
      page: resp.current_page,
      total_pages: resp.total_pages
    });
  }
}

window.OrderFiller = OrderFiller;
