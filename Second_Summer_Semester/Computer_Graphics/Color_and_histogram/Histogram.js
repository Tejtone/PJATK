function preload() {
  img = loadImage("https://raw.githubusercontent.com/scikit-image/scikit-image/master/skimage/data/astronaut.png");
}
function setup() {
  noLoop();
  createCanvas(256,256);
  img.resize(256,256);
  img.filter('gray');
  img.loadPixels();  

 
  var tablica = new Array(10);
  var histogram = new Array(256);
  histogram.fill(0);
  for(x=0;x<img.width;x++)
    for(y=0;y<img.height;y++) { 
      pos = 4 * (y * img.width + x)
      value = img.pixels[pos + 1];
      histogram[value] += 1;
    }
  background(0);
  stroke('white');
  histogram[0] = 0;
    for (x = 0; x < 256; x++) {
        line(x, 0, x, 256 - (histogram[x] / Math.max(...histogram) * 256))
    }
}
