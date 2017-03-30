import NM from '../../api/global.es6';



// shamelessly copied from SO
function mergeSorted(a, b) {
  let dup = new Array(a.length + b.length);
  let i = 0, j = 0, k = 0;
  while(i < a.length && j < b.length) {
    if(a[i].created_at > b[j].created_at) {
      dup[k] = a[i];
      i++;
    }
    else {
      dup[k] = b[j];
      j++;
    }
    k++;
  }
  while(i < a.length) {
    dup[k] = a[i];
    i++;
    k++;
  }
  while(j < b.length) {
    dup[k] = b[j];
    j++;
    k++;
  }
  return dup;
}

class FeedStore {
  constructor(url, type, parent, options = {}) {
    this.url = url;
    this.parent = parent;
    this.type = type;
    this.set = new Set([]);
    this.fetching = false;
    this.hasFurther = true;
    this.items = [];
    this.options = Object.assign({}, FeedStore.DEFAULT_OPTIONS, options);
  }

  add(newItems) {
    console.log(newItems, this.items, this.options.create_field);
    let items = newItems.map((item) =>
      Object.assign({}, item, {
        created_at: new Date(item[this.options.create_field]),
        type: this.type
      })).filter(i => ! this.set.has(i.id));
    // add to set
    items.forEach(i => this.set.add(i.id));
    // Sort for merge
    items.sort((a, b) => b.created_at - a.created_at);
    // perform merge
    this.items = mergeSorted(this.items, items);
    // notify our parent of a change
    this.parent.childChanged();
    return this.items;
  }

  async fetchFurther() {
    if(this.fetching) {
      return -1;
    }
    if(! this.hasFurther) {
      return 0;
    }
    this.startFetch();
    let before = this.items.length;
    let fetchAfter = this.getEarliestDate().valueOf() / 1000;
    let url = this.url + `?fetch_after=${fetchAfter}`;
    console.log("Fetching", {type: this.type, url});
    let resp = await NM.getJSON(url);
    this.add(resp);
    let after = this.items.length;
    let added = after - before;
    console.log("Added " + added);
    if(added == 0) {
      this.hasFurther = false;
    }
    this.endFetch();
    return after;
  }

  startFetch() {
    this.fetching = true;
    this.parent.startFetch();
  }

  endFetch() {
    this.fetching = false;
    this.parent.endFetch();
  }

  getEarliestDate() {
    return this.items[this.items.length - 1].created_at;
  }


  getItems() {
    let items = this.items.slice();
    items.push({
      type: "scroll_sep",
      id: this.type,
      store: this,
      created_at: this.getEarliestDate(),
      hasFurther: this.hasFurther
    });
    return items;
  }
}

FeedStore.DEFAULT_OPTIONS = {
  create_field: "created_at"
};


class DashboardStore {
  constructor(props) {
    this.changeListener = (f) => f;
    this.feeds = [];
    this.fetchingCount = 0;
    this.imageFeed = new FeedStore("/images/feed", "image", this, {
      create_field: "sort_created_at"
    });
    this.imageFeed.add(props.images);
    this.noteFeed = new FeedStore("/notes/feed", "note", this, {});
    this.noteFeed.add(props.notes);
    this.feeds = [this.imageFeed, this.noteFeed];
    this.updateItems();
  }

  updateItems() {
    this.items = this.feeds.map((f) => f.getItems()).reduce(mergeSorted, []);
    return this.items;
  }

  childChanged() {
    this.updateItems();
    this.fireChange();
  }

  getState() {
    return {
      fetching: this.fetchingCount > 0,
      items: this.items,
      hasFurther: this.hasFurther
    };
  }

  setChangeListener(listener) {
    this.changeListener = listener;
  }

  fireChange() {
    this.changeListener(this.getState());
  }

  startFetch() {
    this.fetchingCount++;
    this.fireFetchChange();
  }

  endFetch() {
    this.fetchingCount--;
    this.fireFetchChange();
  }

  fireFetchChange() {
    this.changeListener({
      fetching: this.fetchingCount > 0
    });
  }
}

export default DashboardStore;
