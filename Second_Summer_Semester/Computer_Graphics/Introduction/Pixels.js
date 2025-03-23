function setup() {
  createCanvas(800, 600);
}

//noprotect
function draw() {
  for (y = 0; y < height; y++) 
    for (x = 0; x < width; x++) {
      set(x, y, (x/width)*256)
    }
  
  updatePixels();
}
