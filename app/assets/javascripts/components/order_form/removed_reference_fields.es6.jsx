const RRF = ({id, index}) => (
  <span>
    <input name={`order[references_attributes][${index}][id]`}
      value={id}
      type="hidden" />
    <input name={`order[references_attributes][${index}[_destroy]`}
      value="true"
      type="hidden" />
  </span>
);

export default RRF;
