import React from 'react';
const GroupTag = ({tag, removeSelf}) => (
  <li className="tag-box-added-tag">
    {tag.name}
    <div className="tag-box-remove-tag"
      onClick={removeSelf}>
    </div>
  </li>
);

export default GroupTag
