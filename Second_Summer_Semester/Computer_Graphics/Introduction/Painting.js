function setup() {
  createCanvas(800, 600);
  noLoop();
}

function draw() {
//noprotect
  
//1. Niebo
  for ( y = 0; y < height; y++) {
    for ( x = 0; x < width; x++) {
      set(x, y, color(180, 180, 255));
    }
  }

//2. Trawa
  for ( y = 400; y < height; y++) {
    for ( x = 0; x < width; x++) {
      set(x, y, color(0, 150, 0));
    }
  }
  
//3. Kwiaty
  for ( i = 0; i < 1000; i++) {
     flowerX = floor(random(width));
     flowerY = floor(random(400, height));
     R = floor(random(256));
     G = floor(random(256));
     B = floor(random(256));
    set(flowerX, flowerY, color(R, G, B));
  }
  

//4. Fasada
  for ( y = 200; y < 400; y++) {
    for ( x = 200; x < 600; x++) {
      set(x, y, color(139, 69, 19));
    }
  }

//5. Dach
  for ( y = 100, szer = 0; y < 230; y++, szer++) {
     startX = 400 - (szer * 2);
     endX   = 400 + (szer * 2);

    for ( x = startX; x < endX; x++) {
      set(x, y, color(255, 100, 100));
    }
  }

  updatePixels();
}
