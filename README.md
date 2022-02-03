## Instructions

- Make sure on stable version of node: `sudo n stable`
- Install [Dart Sass](https://github.com/sass/dart-sass#from-homebrew-macos)
- Install Sass: `npm install sass`
- Install Nodemon: `npm install nodemon`
- Run Script: `npm run watch-css`

node.js file:

```
"scripts": {
  "build-css": "sass assets/css/sass/main.scss assets/css/main.css",
  "watch-css": "nodemon -e scss -x \"npm run build-css\""
```
