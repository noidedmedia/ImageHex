const RemovedImageField = ({id, baseFieldName}) => (
  <span>
    <input name={`${baseFieldName}[id]`}
      type="hidden"
      value={id} />
    <input name={`${baseFieldName}[_destroy]`}
      value={1}
      type="hidden" />
  </span>
);

export default RemovedImageField;
