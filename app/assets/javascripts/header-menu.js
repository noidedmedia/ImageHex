function preventDefault(e) {
  e.preventDefault();
}
function headerMenu() {
  document.querySelector("#mobile-menu-icon").addEventListener("click", function() {
    
    document.querySelector("#header-right").classList.toggle("active");
    document.querySelector("#mobile-menu-icon").classList.toggle("active");
    document.querySelector("#mobile-menu-overlay").classList.toggle("active");

    if (document.querySelector("#mobile-menu-icon").classList.contains("active")) {
      document.querySelector("#mobile-menu-icon").addEventListener("click", function() {
        document.querySelector("#mobile-menu-overlay").removeEventListener("click", closeListener);
      });
    }

    setTimeout(clickOverlay, 200);
  });
}
function closeListener() {
 headerMenuClose();
    document.querySelector("#mobile-menu-overlay").removeEventListener("click");
}

function clickOverlay() {
  document.querySelector("#mobile-menu-overlay").addEventListener("click",closeListener);
   ;
}

// This function binds clicking outside of the dropdown to closing the dropdown.
function headerMenuClose() {
  document.querySelector("#header-right").classList.remove("active");
  document.querySelector("#mobile-menu-icon").classList.remove("active");
  document.querySelector("#mobile-menu-overlay").classList.remove("active");
  $("<body>").off("click touchmove");
}

var ready = function() {
  headerMenu();
};

document.addEventListener("turbolinks:load", ready);
