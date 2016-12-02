import React from 'react';

function appendId() {
  $("#comment_body").val($("#comment_body").val() + `@${this}`);
}

const Comment = ({user, id, html_body, created_at}) => {
  var html = {__html: html_body};
  var replyButton;
  if($("body").hasClass("signed-in")) {
    replyButton = <p className="comment-reply"
      onClick={appendId.bind(user.name)}>
      Reply
    </p>;
  }
  var date = new Date(created_at);
  return <div className="comment" id={`comment-${id}`}>
    <div className="user-comment-avatar">
      <a href={`/@${user.slug}`}>
        <img src={user.avatar_path} />
      </a>
    </div>
    <div className="comment-text">
      <div className="comment-user-info">
        <a href={`/@${user.slug}`}>
          {user.name}
        </a>
        <span> commented on </span>
        <time dateTime={date}>
          {date.toLocaleString()}
        </time>
        {replyButton}
      </div>
      <div className="comment-body"
        dangerouslySetInnerHTML={html} />
    </div>
  </div>
};

export default Comment;
