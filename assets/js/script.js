links = document.querySelectorAll(".ga-link");
links.forEach(function (el) {
  el.addEventListener("click", function() {
    var name = el.getAttribute("ga-name");
    ga('send','event','Outbound Link','click', name);
  })
});