var isChrome  = navigator.userAgent.indexOf('Chrome') > -1;
var isFirefox = navigator.userAgent.indexOf('Firefox') > -1;
var isSafari  = navigator.userAgent.indexOf("Safari") > -1;
var isOpera   = navigator.userAgent.toLowerCase().indexOf("op") > -1;
if ((isChrome)&&(isSafari)) {isSafari=false;}
if ((isChrome)&&(isOpera)) {isChrome=false;}

var mailBtn = document.querySelector(".mailto-link");
var mailBtnText = "";

mailBtn.addEventListener("mouseover", function(event) {
  mailBtnText = this.innerHTML;
  mailBtn.innerHTML = "liang.eric24@gmail.com";
})

mailBtn.addEventListener("mouseleave", function(event) {
  mailBtn.innerHTML = mailBtnText;
  mailBtn.classList.remove("mailto-link--success");
})

if (isSafari || isFirefox) {
  mailBtn.classList.add("mailto-link--safari");
  mailBtn.href = "mailto:liang.eric24@gmail.com";
} else {
  mailBtn.addEventListener("click", function(event) {
    var range = document.createRange();
    range.selectNode(mailBtn)
    window.getSelection().addRange(range)

    try {
      var successful = document.execCommand('copy');
      var msg = successful ? 'successful' : 'unsuccessful';
      console.log('Copy email command was ' + msg);
    } catch(err) {
      console.log('Oops, unable to copy');
    }

    if (successful) {
      mailBtn.classList.add("mailto-link--success");
    }

    window.getSelection().removeAllRanges();
  })
}
