import NM from '../../api/global.es6';

const Image = ({img, selected, click}) => {
  let cn = selected ? "image-picker-item selected" : "image-picker-item";
  return <li className={cn}
    onClick={click}>
    <img src={img.medium_thumbnail} />

  </li>
}

class ImagePicker extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    let images = this.props.imageCollection.map((img, ind) => {
      let click;
      let index = this.props.selectedImages.findIndex(i => img.id == i.id);
      if(index === -1) {
        click = this.addImage.bind(this, img);
      }
      else {
        click = this.removeImage.bind(this, img);
      }
      return <Image
        key={img.id}
        img={img}
        click={click}
        selected={index !== -1} />;
    });
    return <ul className="image-picker-list">
      {images}
    </ul>
  }

  addImage(img) {
    this.props.changeSelected([...this.props.selectedImages, img]);
  }

  removeImage(img) {
    let tmp = this.props.selectedImages.slice(0);
    let n = NM.reject(tmp, i => i.id == img.id);
    this.props.changeSelected(n);
  }
}


ImagePicker.propTypes = {
  /**
   * An array of images this user has selected.
   */
  selectedImages: React.PropTypes.array,
  /**
   * A callback called when selectedImages should change.
   * Will pass the new value of selectedImages.
   * If the user chooses, they can ignore this value, filter it,
   * or otherwise modify it.
   */
  changeSelected: React.PropTypes.func,
  /**
   * A collection of potential images a user can select, and which should be
   * displayed.
   *
   * This will typically be fetched with AJAX.
   */
  imageCollection: React.PropTypes.array
}

export default ImagePicker;
