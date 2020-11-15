// This is where it all goes :)
function attachPrintListener() {
  document
    .querySelector(".nav-item__print-button")
    .addEventListener("click", function () {
      window.print();
    });
}

document.addEventListener("DOMContentLoaded", attachPrintListener);
