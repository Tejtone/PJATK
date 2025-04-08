function setup() {
    createCanvas(512, 512);
    background(255);
}

var x0 = -1;
var y0 = -1;
var x1 = -1;
var y1 = -1;

function mousePressed() {
    x0 = mouseX;
    y0 = mouseY;
}

function mouseDragged() {
    x1 = mouseX;
    y1 = mouseY;
    background(255);
    noStroke();
    fill('red');
    ellipse(x0 - 3, y0 - 3, 6);
    fill('green');
    ellipse(x1 - 3, y1 - 3, 6);
}

function mouseReleased() {
    background(255);
    loadPixels();
    draw_distance_map(); // <-- używamy nowej funkcji
    updatePixels();
}

function set_pixel_color(x, y, r, g, b) {
    if (x < 0 || x >= 512 || y < 0 || y >= 512) return;
    let idx = (y * 512 + x) * 4;
    pixels[idx] = r;
    pixels[idx + 1] = g;
    pixels[idx + 2] = b;
    pixels[idx + 3] = 255;
}

function draw_distance_map() {
    let dx = x1 - x0;
    let dy = y1 - y0;

  /*
    maxD = 0;

    // 1. Maksymalna wartość bezwzględna D
    for (x = 0; x < 512; x++) {
        for (y = 0; y < 512; y++) {
            D = 2 * dy * (x - x0) - 2 * dx * (y - y0);
            maxD = Math.max(maxD, Math.abs(D));
        }
    }

    for (x = 0; x < 512; x++) {
        for (y = 0; y < 512; y++) {
            D = 2 * dy * (x - x0) - 2 * dx * (y - y0);

            if (D === 0) {
                set_pixel_color(x, y, 0, 0, 0);
            } else {
                intensity = Math.abs(D) / maxD;
                value = Math.floor(intensity * 255);

                if (D > 0) {
                    set_pixel_color(x, y, 0, value, 0);
                } else {
                    set_pixel_color(x, y, value, 0, 0);
                }
            }
        }
    }
    */
  
      for (x = 0; x < 512; x++) {
        for (y = 0; y < 512; y++) {
            D = 2 * dy * (x - x0) - 2 * dx * (y - y0);

            if (D === 0) {
                set_pixel_color(x, y, 0, 0, 0);
            } else if (D > 0) {
                set_pixel_color(x, y, 0, 255, 0);
            } else {
                set_pixel_color(x, y, 255, 0, 0);
            }
        }
    }
}

