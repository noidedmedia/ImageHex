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
        {this.controls}
      </div>
    </div>;
  }

  get controls() {
    let prevButton, nextButton;
    if(this.hasPreviousPage) {
      prevButton = <a className="control-button previous-button"
        onClick={this.regressPage.bind(this)}>
        ←
      </a>;
    }
    if(this.hasNextPage) {
      nextButton = <a className="control-button next-button"
        onClick={this.advancePage.bind(this)}>
        →
      </a>;
    }
    return <div className="example-image-controls flex-row">
      {prevButton}
      {nextButton}
    </div>
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

  get hasPreviousPage() {
    return this.state.page > 1;
  }

  get hasNextPage() {
    return this.state.totalPages && this.state.page < this.state.totalPages;
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

  advancePage() {
    this.setState({
      page: this.state.page + 1
    }, () => {
      this.fetchPage();
    });
  }

  regressPage() {
    this.setState({
      page: this.state.page - 1
    }, () => {
      this.fetchPage();
    });
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
      return <progress className="full-width-progress active">
      </progress>;
    }
    return <progress className="full-width-progress inactive">
    </progress>
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
      page: q.current_page,
      totalPages: q.total_pages,
      fetching: false
    });
  }
}

export default ExampleImageSection;
