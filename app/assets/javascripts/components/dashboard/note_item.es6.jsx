import React from 'react';
import Creator from './creator';


function NoteItem(props) {
  let html = {__html: props.html_body};
  return <li className="subscription-item">
    <div className="subscription-item-header">
      <a href={`/notes/${props.id}`}>
        {props.title}
      </a>
      <span>
        <time dateTime={props.created_at}>
          {props.created_at.toLocaleString()}
        </time>
      </span>
    </div>
    <div className="subscription-item-note-body">
      <div className="markdown-area" dangerouslySetInnerHTML={html}>
      </div>
    </div>
    <ul className="subscription-item-footer">
      <Creator {...props.user} />
    </ul>
  </li>;
}

export default NoteItem;
