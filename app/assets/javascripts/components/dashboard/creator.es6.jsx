import React from 'react';

function Creator(props) {
  return <li className="subscription-creators-item">
    <a href={`/users/${props.slug}/`}>
      <img className="subscription-avatar"
        src={props.avatar_path} />
      <span>{props.name}</span>
    </a>
  </li>;
}

export default Creator;
