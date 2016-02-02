class InfiniteScroller{
  constructor(container, currentPage){
    this.container = container;
    this.currentPage = Number.parseInt(currentPage);
  }
  go(){
    console.log("Starting infinite scroll", this);
    document.body.addEventListener("scroll", function(){
      console.log("Maybe this works");
    });
  }
  scrollEventHandler(){
    return (event) => {
      console.log("Scrolled in infinite page", this.event);
    }
  }
}
