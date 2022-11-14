PImage fondo, elian, tuberia, pantallaprincipal;
int game, puntuacion, record, x, y, vertical, wallx[] = new int[2], wally[] =new int[2];
import processing.sound.*; //Cargar libreria de sonido para Processing

SoundFile salto;
SoundFile menu;

void setup() {
  size(600,800);
  fill(0,0,0);
  textSize(20);
  menu = new SoundFile(this,"megaman2theme.mp3");
  menu.play();
  
  //Cargar imagenes y Sprites
  
   fondo=loadImage("espaciofondo.jpg");
   elian=loadImage("eliantransparente.png");
   tuberia=loadImage("tuberia.png");
   pantallaprincipal=loadImage("pantallaprincipal.jpg");
   
   //Inicializacion de variables
   game = 1; puntuacion = 0; record = 0; x = -200; vertical = 0; 
  
}
void draw() { 
  
  if(game == 0) {
    imageMode(CORNER);
    image(fondo, x, 0);
    image(fondo, x+fondo.width, 0);
    x -= 5;
    vertical += 1;
    y += vertical;
    if(x == -1800) x = 0;
    
        for(int i = 0 ; i < 2; i++) {
          imageMode(CENTER);
          image(tuberia, wallx[i], wally[i] - (tuberia.height/2+100));
          image(tuberia, wallx[i], wally[i] + (tuberia.height/2+100));
          if(wallx[i] < 0) {
            wally[i] = (int)random(200,height-200);
            wallx[i] = width;
          }
          if(wallx[i] == width/2) record = max(++puntuacion, record);
          if(y>height||y<0||(abs(width/2-wallx[i])<25 && abs(y-wally[i])>100)) game=1;
          wallx[i] -= 6;
    }
    image(elian, width/2, y);
    fill(#E5EDEF);
    translate(20,50);
    text("PUNTUACIÓN: "+puntuacion, 10, 20);
  }
  else {
    imageMode(CENTER);
    image(pantallaprincipal, width/2,height/2);
    fill(#F7F7F3);
    translate(10,400);
    text("RECORD ACTUAL: "+record, 50, 130);
  }
  
}


void mousePressed() {
  menu.pause();
  salto = new SoundFile(this,"jumpsound.mp3");
  salto.play();
  vertical = -15;
  if(game==1) {
    wallx[0] = 600;
    wally[0] = y = height/2;
    wallx[1] = 900;
    wally[1] = 600;
    x = game = puntuacion = 0;
  }
  
}
