links = document.querySelectorAll(".ga-link");
links.forEach(function (element) {
  var name = element.getAttribute("ga-name");

  /* Send the event to Google Analytics */
  ga('send','event','Outbound Link','click',name);
});
