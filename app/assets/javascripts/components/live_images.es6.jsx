class LiveImages extends React.Component {
  render() {
    var collection = Image.allImages();
    return <ImageCollectionComponent collection={collection}
          showContentRatings={true} />;
  }
}
