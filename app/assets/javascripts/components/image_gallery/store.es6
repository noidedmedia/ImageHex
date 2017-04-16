import NM from '../../api/global';
import $ from 'jquery';

class Store {
  constructor(props) {
    this.baseUrl = props.base_url || window.location.href;
    this.page = props.page || 1;
    this.perPage = props.perPage || 20;
    this.images = props.images || [];
    this.changeHandlers = [];
    this.fetching = false;
    this.hasFurther = true;
  }

  async fetchFurther() {
    console.log("Fetching further...");
    if(this.fetching) {
      console.log("Already fetching, bailing...");
      return false;
    }
    this.fetching = true;
    await this.fireChange();
    this.page = this.page + 1;
    let imgs = await NM.getJSON(this.currentUrl);
    if(imgs.images.length == 0) {
      this.hasFurther = false;
    }
    this.pushHistory();
    this.fetching = false;
    this.images = [...this.images, ...imgs.images];
    return await this.fireChange()
  }


  get currentUrl() {
    let query = $.param({page: this.page, per_page: this.perPage});
    if(this.baseUrl.endsWith("?")) {
      return this.baseUrl + query;
    }
    else if(this.baseUrl.includes("?")) {
      return this.baseUrl + "&" + query;
    }
    else {
      return this.baseUrl + "?" + query;
    }
  }

  addChangeHandler(handler, fireChange = false) {
    this.changeHandlers.push(handler);
    if(fireChange) {
      this.fireChange();
    }
  }

  pushHistory() {
    let url = this.currentUrl;
    if(! window.History || ! window.History.enabled) {
      return;
    }
    window.History.pushState(null,
      `Page ${this.currentPage}`,
      url);
  }

  async fireChange() {
    let p = this.changeHandlers.map(x => Promise.resolve(x(this.getState())));
    await Promise.all(p);
  }

  getState() {
    return {
      page: this.page,
      perPage: this.perPage,
      images: this.images,
      fetching: this.fetching,
      hasFurther: this.hasFurther
    };
  }
};

export default Store;
