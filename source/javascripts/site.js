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
  return path.split("/").length - 1;
}

function attachPastLinkListener() {
  if (window.location.pathname === "/") {
    // we're at root - no need to fix links
    return;
  }
  const curPath = window.location.pathname;
  document
    .querySelectorAll(".past-issues__link[href], .nav-item__info-link[href]")
    .forEach(function (link) {
      const depth = directoryDepth(curPath);
      if (depth > 0) {
        const directories = curPath.split("/").slice(1, depth - 1);
        directories.push(link.getAttribute("href"));
        let newPath = "/" + directories.join("/");
        if (newPath === "//") {
          newPath = "/";
        }
        link.addEventListener("click", function (ev) {
          ev.preventDefault();
          window.location.href = newPath;
        });
      }
    });
}

document.addEventListener("DOMContentLoaded", attachPrintListener);
document.addEventListener("DOMContentLoaded", attachPastLinkListener);
