// This is where it all goes :)
function attachPrintListener() {
  document
    .querySelector(".nav-item__print-button")
    .addEventListener("click", function () {
      window.print();
    });
}

// fix up links for github pages deployment
function directoryDepth(path) {
  return path.match(/(\/)/).length - 1;
}

function attachPastLinkListener() {
  document
    .querySelectorAll(".past-issues__link[href]")
    .forEach(function (link) {
      if (directoryDepth(window.location.pathname) > 0) {
        const directories = window.location.pathname.split("/").slice(0, -2);
        directories.push(link.getAttribute("href"));
        const newPath = directories.join("/");
        link.addEventListener("click", function (ev) {
          ev.preventDefault();
          window.location.href = newPath;
        });
      }
    });
}

document.addEventListener("DOMContentLoaded", attachPrintListener);
document.addEventListener("DOMContentLoaded", attachPastLinkListener);
