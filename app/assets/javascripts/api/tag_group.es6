class TagGroup {
  constructor(json) {
    this.tags = [];
    for (var prop in json) {
      if (prop == "tags") {
        for (var tag of json.tags) {
          this.tags.push(new Tag(tag)); 
        }
      }
      else {
        this[prop] = json[prop];
      }
    }
  }
  addTag(tag) {
    this.tags.push(tag);
  }
  removeTag(tag) {
    for (var t in this.tags) {
      if (this.tags[t].id == tag.id) {
        this.tags.splice(t, 1);
      }
    }
  }
}

