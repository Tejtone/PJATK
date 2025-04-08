function setup() {
    createCanvas(512,512);
    background(255);
}

var last_x=-1;
var last_y=-1;
function mouseDragged() {  
  if(mouseButton != LEFT) return;
  if(last_x>0) {
    line(last_x,last_y,mouseX,mouseY);
  }
  last_x=mouseX;
  last_y=mouseY;
}

function mouseReleased() {
  last_x=last_y=-1;
  if(mouseButton == RIGHT) {
    loadPixels();
    flood_fill(mouseX,mouseY);
    updatePixels();
  }
  
}
function set_pixel(x,y,c) {
    idx=(y*512+x)*4;
    pixels[idx]=c;
    pixels[idx+1]=c;
    pixels[idx+2]=c;
    pixels[idx+3]=255;
}
   
function get_pixel(x,y) {
 idx=(y*512+x)*4;
 return pixels[idx];
}
  
function flood_fill(x, y) {
  // tworzymy pusty stos
  
    stos = [];
  // współrzędne kliknięcia myszy
  
    stos.push([x, y]);

    while (stos.length > 0 && cnt > 0) {

        [px, py] = stos.pop();
      
  // sprawdzamy poprawność współrzędnych, jeśli się nie mieszczą dajemy continue
        if (px < 0 || px >= 512 || py < 0 || py >= 512) continue;

        kolor = get_pixel(px, py);
      
  // sprawdzamy czy kolor ten nie jest biały, to dajemyu continue
        if (kolor !== 255) continue;
        
  // zamalujemy bieżący piksel
        set_pixel(px, py, 200);

  // dodajemy do stosu sąsiadów bieżącego piksela
        stos.push([px, py - 1]);
        stos.push([px, py + 1]);
        stos.push([px - 1, py]);
        stos.push([px + 1, py]);
        
        
        
    }
}
