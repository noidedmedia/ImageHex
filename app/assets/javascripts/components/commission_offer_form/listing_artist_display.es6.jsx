const ListingArtistDisplay = ({name, id, avatar_path}) => (
  <div className="listing-artist-display">
    <img src={avatar_path} />
    <a href={`/users/${id}`} target="_blank">
      {name}
    </a>
  </div>
)

export default ListingArtistDisplay;
