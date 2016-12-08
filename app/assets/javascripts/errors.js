// Close the Alert dialog when the close icon is clicked.
 function hideError() {
  if (document.getElementsByClassName("alert").length > 0) {
    document.querySelector("#alert-close").addEventListener("click", function() {
      document.querySelector(".alert").style.display = "none";
    });
  }
}

var ready = function() {
  if (document.querySelector(".alert")) {
    hideError();
  }
};

document.addEventListener("turbolinks:load", ready);
