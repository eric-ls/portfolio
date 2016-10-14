var isChrome  = navigator.userAgent.indexOf("Chrome") > -1;
var isFirefox = navigator.userAgent.indexOf("Firefox") > -1;
var isSafari  = navigator.userAgent.indexOf("Safari") > -1;
var isOpera   = navigator.userAgent.toLowerCase().indexOf("op") > -1;
if ((isChrome)&&(isSafari)) {isSafari=false;}
if ((isChrome)&&(isOpera)) {isChrome=false;}

/* Spotify gradient animation on hover */
var spotifyHovered = false;
var spotify = document.querySelector(".spotify-project");
var spotifyBG = spotify.querySelector("#spotify-bg");
var bgWidth = spotify.offsetWidth;

if (!isSafari) {
  spotify.addEventListener("mousemove", function(event) {
    var mousePercent = (event.layerX / bgWidth) * 100;
    var blue = modulate(mousePercent, [0, 100], [-5, 30]);
    var green = modulate(mousePercent, [0, 100], [90, 110]);
    var degree = modulate(mousePercent, [0, 100], [135, 150]);
    spotifyBG.style.background = `linear-gradient(${degree}deg,#2B44A6 ${blue}%,#2FE48F ${green}%)`;
    spotifyBG.style.background = `-moz-linear-gradient(${degree+180}deg,#2B44A6 ${blue}%,#2FE48F ${green}%)`;
  })
}

/* FramerJS Modulate Function */
var modulate = function(value, rangeA, rangeB, limit) {
  var fromHigh, fromLow, result, toHigh, toLow;
  if (limit == null) {
    limit = false;
  }
  fromLow = rangeA[0], fromHigh = rangeA[1];
  toLow = rangeB[0], toHigh = rangeB[1];
  result = toLow + (((value - fromLow) / (fromHigh - fromLow)) * (toHigh - toLow));
  if (limit === true) {
    if (toLow < toHigh) {
      if (result < toLow) {
        return toLow;
      }
      if (result > toHigh) {
        return toHigh;
      }
    } else {
      if (result > toLow) {
        return toLow;
      }
      if (result < toHigh) {
        return toHigh;
      }
    }
  }
  return result;
};
