function preload() {
  img = loadImage("https://raw.githubusercontent.com/scikit-image/scikit-image/master/skimage/data/astronaut.png");
  img_r = createImage(256, 256);
  img_g = createImage(256, 256);
  img_b = createImage(256, 256);
  img_sum = createImage(256, 256);
}

function setup() {
  createCanvas(512, 512);
  
  img.resize(256, 256);
  
  // Ładowanie pikseli wszystkich obrazów
  img.loadPixels();
  img_r.loadPixels();
  img_g.loadPixels();
  img_b.loadPixels();
  
  d = pixelDensity();
  
  for(x = 0; x < img.width; x++) {
    for(y = 0; y < img.height; y++) {
      for(dx = 0; dx < d; dx++) {
        for(dy = 0; dy < d; dy++) {
          pos = 4 * ((y * d + dy) * img.width * d + (x * d + dx));
          
          // Pobieranie wartości R, G, B z oryginalnego obrazu
          r = img.pixels[pos];
          g = img.pixels[pos + 1];
          b = img.pixels[pos + 2];
          
          // Ustawianie wartości dla obrazu R
          img_r.pixels[pos] = r;
          img_r.pixels[pos + 1] = 0;
          img_r.pixels[pos + 2] = 0;
          img_r.pixels[pos + 3] = 255;
          
          // Ustawianie wartości dla obrazu G
          img_g.pixels[pos] = 0;
          img_g.pixels[pos + 1] = g;
          img_g.pixels[pos + 2] = 0;
          img_g.pixels[pos + 3] = 255;
          
          // Ustawianie wartości dla obrazu B
          img_b.pixels[pos] = 0;
          img_b.pixels[pos + 1] = 0;
          img_b.pixels[pos + 2] = b;
          img_b.pixels[pos + 3] = 255;
        }
      }
    }
  }
  
  // Aktualizacja wszystkich obrazów
  img_r.updatePixels();
  img_g.updatePixels();
  img_b.updatePixels();
  
  // Tworzenie obrazu sumarycznego
  img_sum.copy(img_r, 0, 0, 256, 256, 0, 0, 256, 256);
  img_sum.blend(img_g, 0, 0, 256, 256, 0, 0, 256, 256, ADD);
  img_sum.blend(img_b, 0, 0, 256, 256, 0, 0, 256, 256, ADD);
  
  // Wyświetlanie wszystkich obrazów
  image(img_r, 0, 0);
  image(img_g, 256, 0);
  image(img_b, 0, 256); 
  image(img_sum, 256, 256); 
}
