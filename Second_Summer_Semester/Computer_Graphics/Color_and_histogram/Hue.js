function preload() {
  img = loadImage("https://raw.githubusercontent.com/scikit-image/scikit-image/master/skimage/data/astronaut.png");
  img_h = createImage(256, 256);
  img_s = createImage(256, 256);
  img_v = createImage(256, 256);
}

function setup() {
  createCanvas(512, 512);
  
  img.resize(256, 256);
  
  // Ładowanie pikseli wszystkich obrazów
  img.loadPixels();
  img_h.loadPixels();
  img_s.loadPixels();
  img_v.loadPixels();
  
  d = pixelDensity();
  
  for(x = 0; x < img.width; x++) {
    for(y = 0; y < img.height; y++) {
      for(dx = 0; dx < d; dx++) {
        for(dy = 0; dy < d; dy++) {
          pos = 4 * ((y * d + dy) * img.width * d + (x * d + dx));
          
          r = img.pixels[pos] / 255;
          g = img.pixels[pos + 1] / 255;
          b = img.pixels[pos + 2] / 255;
          
          cmax = Math.max(r, g, b);
          cmin = Math.min(r, g, b);
          c = cmax - cmin;
          
          // Obliczanie składowej V (Value/Brightness)
          let v = cmax;
          
          // Obliczanie składowej S (Saturation) dla modelu HSV
          let s;
          if (cmax === 0) {
            s = 0;
          } else {
            s = c / cmax;
          }
          
          // Obliczanie składowej H (Hue)
          let h;
          if (c === 0) {
            h = 0;
          } else if (cmax === r) {
            h = ((g - b) / c) % 6;
          } else if (cmax === g) {
            h = ((b - r) / c) + 2;
          } else { // cmax === b
            h = ((r - g) / c) + 4;
          }
          
          h /= 6;
          if (h < 0) h += 1
          
          // Hue
          h_scaled = Math.round(h * 255);
          img_h.pixels[pos] = h_scaled;
          img_h.pixels[pos + 1] = h_scaled;
          img_h.pixels[pos + 2] = h_scaled;
          img_h.pixels[pos + 3] = 255;
          
          // Saturation
          s_scaled = Math.round(s * 255);
          img_s.pixels[pos] = s_scaled;
          img_s.pixels[pos + 1] = s_scaled;
          img_s.pixels[pos + 2] = s_scaled;
          img_s.pixels[pos + 3] = 255;
          
          // Value/Brightness
          v_scaled = Math.round(v * 255);
          img_v.pixels[pos] = v_scaled;
          img_v.pixels[pos + 1] = v_scaled;
          img_v.pixels[pos + 2] = v_scaled;
          img_v.pixels[pos + 3] = 255;
        }
      }
    }
  }
  
  img_h.updatePixels();
  img_s.updatePixels();
  img_v.updatePixels();
  
  // Wyświetlanie obrazów
  image(img_h, 0, 0);
  image(img_s, 256, 0);
  image(img_v, 0, 256);
  image(img, 256, 256);
}
