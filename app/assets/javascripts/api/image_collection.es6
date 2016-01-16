/**
 * Represents a collection of multiple images
 */
class ImageCollection {
  /**
   * Create a new collection from the URL
   * @param{String} url the url to look for
   * @param{String} prefix the optoinal prefix to find in the JSON given by url
   */
  constructor(url, prefix) {
    this.url = url;
    this.current_page = 1;
    this.prefix = prefix;
    this.page = 1;
  }
  
  iteratePageImages(callback) {
    this.getPageImages((i) => {
      i.forEach(callback);
    });
  }

  /**
   * Increment this ImageCollection's page value
   * Returns `this` if there is a next page, and `undefined` otherwise
   */
  nextPage() {
    if (this.hasNextPage()) {
      this.page = this.page + 1;
      return this;
    } else {
      return undefined;
    }
  }

  previousPage(){
    if(this.hasPreviousPage()){
      this.page = this.page - 1;
      return this;
    } else {
      return undefined;
    }
  }

  currentPage(){
    return this.page;
  }

  hasNextPage() {
    console.log("Check if we ahve a next page with page",this.page);
    return !!(this.total_pages && ! this.page + 1  > this.total_pages);
  }

  hasPreviousPage() {
    console.log("Checking if we have a previous page with page",this.page);
    return (this.page > 1);
  }

  getPageImages(callback) {
    this.getPageData((d) => {
      var imgs = [];
      for (var img of d.images) {
        imgs.push(new Image(img));
      }
      callback(imgs);
    });
  }

  getPageData(callback) {
    NM.getJSON(this.pageURL(), (data) => {
      var d;
      if (this.prefix) {
        d = data[this.prefix];
      } else {
        d = data;
      }
      this.total_pages = d.total_pages;
      callback(d);
    });
  }
  
  pageQueryParams() {
    return $.param({
      page: this.current_page
    });
  }

  pageURL() {
    return this.url + "?" + this.pageQueryParams();
  }
}
