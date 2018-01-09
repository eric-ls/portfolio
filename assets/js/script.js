links = document.querySelectorAll(".ga-link");
links.forEach(function (el) {
  el.addEventListener("click", function() {
    var name = el.getAttribute("ga-name");
    ga('send','event','Outbound Link','click', name);
  })
});

resumeURLs = document.querySelectorAll(".resume-url-target");
resumeURLs.forEach(function (el) {
	el.setAttribute("href", "https://www.dropbox.com/s/s9vti89m8sfnsi1/eric_liang_resume.pdf?dl=0");
})