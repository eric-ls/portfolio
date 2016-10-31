links = document.querySelectorAll(".ga-link");
links.forEach(function (element) {
  element.addEventListener("click", function() {
    var name = element.getAttribute("ga-name");
    ga('send','event','Outbound Link','click', name);
  })
});
