function setup() {
    createCanvas(512, 512);
    background(255);
}

let x0 = -1;
let y0 = -1;
let x1 = -1;
let y1 = -1;

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
    draw_bresenham_line(); // wywołujemy algorytm Bresenhama
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

function draw_bresenham_line() {
  
    dx = x1 - x0;
    dy = y1 - y0;

    D = 2 * dy - dx;
    Deq = 2 * dy;
    Dinc = 2 * (dy - dx);

    y = y0;

    for (x = x0; x <= x1; x++) {
        set_pixel_color(x, y, 0, 0, 0);

        if (D < 0) {
            D += Deq;
        } else {
            D += Dinc;
            y++;
        }
    }
}
