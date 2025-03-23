function setup() {
  createCanvas(800, 600);
  noLoop();
}

function draw() {
//noprotect

  for ( y = 0; y < height; y++) {
    for ( x = 0; x < width; x++) {
      
//1. Należy policzyć odległość współrzędnej x od środka ekranu
       centerX = width / 2;
       dx = x - centerX;
      
//2. Należy to samo policzyć dla współrzędnej y
       centerY = height / 2;
       dy = y - centerY;
      
//3. Należy policzyć pierwiastek sumy kwadratów
       d = sqrt(dx * dx + dy * dy);

       R = 255 - d;
       G = d;
       B = ((x + y) / (width + height)) * 255;

      set(x, y, color(R, G, B));
    }
  }

  updatePixels();
}
