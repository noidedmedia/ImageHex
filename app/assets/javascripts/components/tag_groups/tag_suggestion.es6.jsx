const TagSuggestion = ({tag, isActive, addSelf}) => {
  let className = "tag-group-tag-suggestion";
  if(isActive) {
    className += " active";
  }
  return <li className={className}
    onClick={addSelf}>
    <span>{tag.name}</span>
  </li>;
}

export default TagSuggestion;
