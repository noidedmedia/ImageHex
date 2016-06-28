import ImagePicker from '../image_picker/image_picker.es6.jsx';
import NM from '../../api/global.es6';

class ExampleImageSection extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      fetching: false,
      selectedImages: [],
      activeImages: [],
      page: 1,
      active: true
    };
  }

  render() {
    let cn = "listing-example-images-section";
    if(this.state.active) {
      cn += " active";
    }
    else {
      cn += " inactive";
    }
    return <div className={cn}>
      <div className="listing-form-section-header"
        id="example-image-section">
        <h1>Example Images</h1>
        <div className="description">
          Provide example images, to give users an 
          idea of what they will get from this commission.
          Select a few from your creations:
        </div>
      </div>
      {this.activateBar}
      <div className="lower-section">
        <ImagePicker
          imageCollection={this.state.activeImages}
          selectedImages={this.state.selectedImages}
          changeSelected={this.changeSelected.bind(this)} />
        {this.progressBar}
        {this.formFields}
      </div>
    </div>;
  }


  get formFields() {
    const fieldName = "listing[image_ids][]";

    return this.state.selectedImages.map((img, i) => (
      <input type="hidden"
        key={img.id}
        name={fieldName}
        value={img.id} />
    ));
  }

  get activateBar() {
    if(this.state.active) {
      return <div className="example-images-activate-bar active"
        onClick={this.deactivate.bind(this)} />
    }
    else {
      return <div className="example-images-activate-bar inactive"
        onClick={this.activate.bind(this)} />
    }
  }

  activate() {
    this.setState({
      active: true
    });
  }

  deactivate() {
    this.setState({
      active: false
    });
  }
  get progressBar() {
    if(this.state.fetching) {
      return <progress></progress>;
    }
    return "";
  }

  changeSelected(selected) {
    this.setState({
      selectedImages: selected
    });
  }

  componentDidMount() {
    this.fetchPage();
  }

  async fetchPage() {
    this.setState({
      fetching: true
    });
    let { page } = this.state;
    let id = window.CURRENT_USER_ID;
    let url = `/users/${id}/creations.json?page=${page}`;
    let q = await NM.getJSON(url);
    this.setState({
      activeImages: q.images,
      page: q.page,
      total_pages: q.total_pages,
      fetching: false
    });
  }
}

export default ExampleImageSection;
