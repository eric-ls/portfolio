exports.task = {
  my_target: {
    files: [{
      expand: true,
      cwd: '../assets/css/',
      src: [ '*.css', '!*.min.css' ],
      dest: '../assets/css/',
      ext: '.min.css'
    }]
  }
};
