import React from 'react';

export default (id, index) => {
  let fieldName = (name) => (`order[reference_groups][${index}][${name}`);
  return <div class="removed-group-ids">
    <input type="hidden" 
      name={fieldName("id")}
      value={id} />
    <input type="hidden"
      name={fieldname("_destroy")}
      value="1" />
  </div>;
};
