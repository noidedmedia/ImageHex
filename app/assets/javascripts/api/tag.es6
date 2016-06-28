import NM from './global.es6';

class Tag {
  constructor(json) {
    for (var prop in json) {
      this[prop] = json[prop];
    }
  }

  static create(props, callback) {
    var c = (tag) => {
      console.log("Create gave us a new tag");
      callback(new Tag(tag));
    };
    NM.postJSON("/tags/",
                props,
                c);
    // Reset prefix buffer
    Tag.prefix_buffer = {};
  }
  getFullData(callback) {
    if ("description" in this) {
      callback(this);
    }
    else {
      Tag.find(this.id, callback);
    }
  }
  /**
   * Get an ImageCollection representing all images with this tag.
   */
  images() {
    return new ImageCollection("/tags/" + this.id, "images");
  }
  /**
   * Find a tag by an ID or a slug.
   * @param{(number|string)} id the id or slug of the tag
   * @param{Function} callback the callback to call with the Tag
   */
  static find(id, callback) {
    NM.getJSON("/tags/" + id, (t) => {
      callback(new Tag(t));
    });
  }

  static withPrefixBuffered(prefix, resolve) {
    // All tags that start with the first 2 letters
    var pf = Tag.prefix_buffer[prefix.substring(0, 1)]
    // Get only tags that start with the entire prefix
    var f = pf.filter((val) => {
      return val.name.toLowerCase().startsWith(prefix.toLowerCase());
    });
    resolve(f);
  }

  static hasPrefixFromBuffer(prefix) {
    return Tag.prefix_buffer[prefix.substring(0, 1)];
  }
  /**
   * Get all tags with a prefix
   * @param{String} prefix the prefix
   * @param{Function} callback called with the array of tags
   */
  static withPrefix(prefix, buffered) {
    return new Promise(async function(resolve, reject) {
      prefix = prefix.toLowerCase();
      if(buffered && Tag.hasPrefixFromBuffer(prefix)) {
        return Tag.withPrefixBuffered(prefix, resolve);
      }
      let query = $.param({name: prefix});
      let uri = `/tags/suggest.json?${query}`;
      let tags = await NM.getJSON(uri);
      let mapped = tags.map(t => new Tag(t));
      Tag.addBuffer(mapped, prefix);
      resolve(mapped);
    });
  }

  static addBuffer(ar, prefix) {
    Tag.prefix_buffer[prefix.toLowerCase().substring(0, 1)] = ar;
  }
}

Tag.prefix_buffer = {};

export default Tag;
