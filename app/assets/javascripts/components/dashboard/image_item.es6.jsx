import React from 'react';
import Creator from './creator.es6.jsx';

function reason_path(img) {
  var {reason_id, reason_type} = img;
  if(typeof reason_id === 'undefined') {
    return "";
  }
  if(reason_type === "user") {
    return "/users/" + reason_id;
  }
  else if(reason_type === "collection") {
    return "/collections/" + reason_id;
  }
  else {
    return "";
  }
}

function ImageItem(props) {
  var url = reason_path(props);
  let date = new Date(props.sort_created_at);
  var creators = (props.creators || []).map((c, index) => {
    return <Creator {...c} key={index} />;
  });
  return <li className="subscription-item">
    <div className="subscription-item-header">
      <a href={reason_path(props)}>
        {props.reason}
      </a>
      <span>
        <time dateTime={new Date(props.sort_created_at)}>
          {date.toLocaleString()}
        </time>
      </span>
    </div>
    <a href={`/images/${props.id}`}
      className="subscription-item-image">
      <img src={props.large_url} />
    </a>
    <ul className="subscription-item-footer">
      {creators}
    </ul>
  </li>;
}

export default ImageItem;
