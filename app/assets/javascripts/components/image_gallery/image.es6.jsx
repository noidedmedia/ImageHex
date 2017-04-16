import React, { Component } from 'react';

let Image = ({large_thumbnail, url}) => <li className="image-gallery-item">
  <a href={url}>
    <img src={large_thumbnail} />
  </a>
</li>;

export default Image;
