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
    steep = false;

    // Zamieniamy miejscami wartości zmiennych
    dx = Math.abs(x1 - x0);
    dy = Math.abs(y1 - y0);

    // 2. Sprawdzamy czy linia jest stroma (kąt > 45°)
    if (dy > dx) {
        // Zamieniamy x i y
        [x0, y0] = [y0, x0];
        [x1, y1] = [y1, x1];
        [dx, dy] = [dy, dx];
        steep = true;
    }

    // Zwiększamy lub zmiejszami zależne od x0/y0
    sx = x0 < x1 ? 1 : -1;
    sy = y0 < y1 ? 1 : -1;

    D = 2 * dy - dx;
    x = x0;
    y = y0;

    for (i = 0; i <= dx; i++) {
        if (steep) {
            set_pixel_color(y, x, 0, 0, 0); // zamieniona kolejność współrzędnych
        } else {
            set_pixel_color(x, y, 0, 0, 0);
        }

        if (D > 0) {
            y += sy;
            D -= 2 * dx;
        }
        D += 2 * dy;
        x += sx;
    }
}


