// 1. Zdefiniuj 3 punkty
x1 = 400, y1 = 50;
x2 = 100, y2 = 550;
x3 = 700, y3 = 550;

function setup() {
  createCanvas(800, 600);
  noLoop();
}

function draw() {
//noprotect

// 2. Kolor tła czarny
  background(0);
  
// 3. Ustaw kolor rysowania na biały funkcją stroke
  stroke(255);
  
//4. Użyj funkcji point do zamalowania 3 punktów
  point(x1, y1);
  point(x2, y2);
  point(x3, y3);
  
//5. Zdefiniuj nową parę współrzędnych  
   cx = x1;
   cy = y1;
  
//6. Pętla
  for ( i = 0; i < 30000; i++) {
     r = floor(random(3));
    
    switch (r) {
      case 0:
        cx = (cx + x1) / 2;
        cy = (cy + y1) / 2;
        break;
      case 1:
        cx = (cx + x2) / 2;
        cy = (cy + y2) / 2;
        break;
      default: // czyli 2
        cx = (cx + x3) / 2;
        cy = (cy + y3) / 2;
        break;
    }
    point(cx, cy);
  }
  
  updatePixels();
}
