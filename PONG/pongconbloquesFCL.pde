/* pong con bloques*/

/* FLOR CORREA LÓPEZ
 2ºBACH.B IES VICENTE ALEIXANDRE
 */

//BOLA
float posxbola=width/2; // posicion mitad del ancho
float posybola=height/2; // posicion mitad del alto
float velxbola= 1; // velocidad en x
float velybola=3; // velocidad en y
float radio=12; // radio de la bola

//velocidad y rebote
float inicioVelXmax=5;
float inicioVelYmin=5;
float velXmax;
float velYmax;
float velYmin;
float aumentoVelocidad=0.2;
float difPos;


//PALA
float altopala=15; //alto de la barra
float anchopala=100; // ancho de la barra
float posypala=450; // posicion en y de la barra
float posxpala=0; // posicion de la pala en X

PFont letra; // letra de inicio

int pantalla=0; // distintas pantallas de juego

//BLOQUES  
int numBloques=5;
Bloque[] miBloque1 = new Bloque[numBloques];


// variables 
int vidas = 3;
int puntos=0;

void setup() {

  size (500, 500); // pantalla de juego
  colorMode(HSB, height, height, height); // paleta de colores
  letra= createFont("ColonnaMT-48", 30); // tipo de letra que queremos
  
  pantalla=0;
  vidas=3;
  iniciovariables();
  crearBloque();
}


void draw() {

  stroke(255, 255, 255); // color linea exterior de inicio
  background(#98CBC2); // fondo de color

  switch (pantalla) { // cambiar las pantallas de juego
  case 0:
    inicio(); // pantalla principal de inicio
    break;

  case 1:
    juego(); // pantalla de juego
    break;

  case 2:
    perdido(); // pantalla de has perdido
    break;
case 3:
    ganado(); //Fin del juego: has ganado
    break;
 
  }
}

void iniciovariables() {

  posxbola=width/2; // posicion x de la bola
  posybola=height/2; // posicion y de la bola
  velxbola=random(2, 5); // velocidad x aleatoria de la bola
  velybola=random(2, 5); // velocidad y de la bola

  velXmax=inicioVelXmax;
  velYmin=inicioVelYmin;
  velYmax=sqrt(sq(velXmax)+sq(velYmin));

}

void inicio() {

  //ENUNCIADO PONG: tipo de letra, colorear, centrar, escribir texto
  textFont(letra, 80);  
  fill(mouseX, mouseY, width);
  textAlign(CENTER);
  text("PONG", 250, 150);

  // ENUNCIADO INSTRUCCIONES: tipo de letra, colorear, centrar, texto
  textFont(letra, 35);
  fill(mouseX, width);
  textAlign(CENTER);
  text("INSTRUCCIONES:", 250, 270);
  textFont(letra, 27);
  text ("Utiliza el ratón para mover la pala", 250, 320);

  //ENUNCIADO PLAY: color de fondo de la elipse,color linea, crear dos elipses, tipo de letra, colorear, centrar, texto
  fill(#98CBC2);
  stroke(#FFFFFF);
  ellipse(248, 390, 190, 80);
  ellipse(248, 390, 180, 70);
  textFont(letra, 40);
  fill(#FFFFFF);
  textAlign(CENTER);
  text("PLAY", 250, 403);

  //NOMBRE EN ESQUINA INFERIOR DERECHA: letra,relleno de color,centrar,texto
  textFont(letra, 20);
  fill(mouseX, mouseY, width);
  textAlign(CENTER);
  text("Flor Correa López", 400, 470);
}

void juego() {

  //Definimos el texto de los puntos y las vidas
  textSize(20); 
  fill(0);
  textAlign(RIGHT);
  text(vidas + " VIDAS", width-width/20, height/20);
  textAlign(LEFT);
  text("PUNTOS: " + puntos, width/20, height/20);

  difPos=posxbola-mouseX;
  
  dibujarbola(); //dibujar la bola
  dibujarpala(); // dibujar la pala
  dibujarBloque();
  
  moverbola(); // movimiento bola
  moverpala(); // movimiento pala
  
  rebotes(); // rebotes pantalla y pala
  
  terminarPartida();
  
}

// DIBUJAR PALA: linea de color blanco, relleno, grosor de linea, dibujo de la pala
void dibujarpala() {

  stroke(#FFFFFF);
  fill(#ED62A3);
  strokeWeight(2);
  rect(posxpala, posypala, anchopala, altopala, 7); // el último parametro es para redondear el rectángulo
}

//DIBUJAR BOLA: linea de color blanco, relleno, grosor de linea, dibujo de la bola
void dibujarbola() {

  stroke(#FFFFFF);
  fill(#ED62A3);
  strokeWeight(2);
  ellipse(posxbola, posybola, radio*2, radio*2);
}

// MOVIMIENTO BOLA
void moverbola() {

  posxbola=posxbola+velxbola; // cambiar la posicion X sumando la velocidad x
  posybola=posybola+velybola;  // cambiar la posicion Y sumando la velocidad y
}

//MOVIMIENTO PALA
void moverpala() {

  rectMode(CENTER); //centro en el la pala
  posxpala=mouseX;
  posypala=450;// posicion de la pala en X
}  

//REBOTES
void rebotes() {

  //Rebote Y
  if (posybola<=0) {
    velybola=velybola*-1;
  }

  //Rebote X
  if (posxbola+radio >= width || posxbola<= 0 ) {
    velxbola = velxbola*-1;
  }

  //REBOTE CON PALA
  if ( difPos<=anchopala/2+radio && difPos>=-(anchopala/2+radio) && posybola>=posypala-radio && posybola<=posypala+radio ) {

    velXmax=velXmax+aumentoVelocidad;
    velYmin=velYmin+aumentoVelocidad;
    velYmax=sqrt(sq(velXmax)+sq(velYmin));

    velxbola= difPos*velXmax/(anchopala/2+radio);
    if (difPos <0) {
      velybola= -(-difPos*(velYmin-velYmax)/(anchopala/2+radio)+velYmax);
    } else {
      velybola= -(difPos*(velYmin-velYmax)/(anchopala/2+radio)+velYmax);
    }
  }
}

void ganado() {
textFont(letra, 60);
  fill(mouseX, mouseY, height);
  textAlign(CENTER);
  text("Has ganado", 250, 120);

  textFont(letra, 40);
  fill(#FFFFFF);
  textAlign(CENTER);
  text("Dale al botón", 250, 220);
  textFont(letra, 40);
  textAlign(CENTER);
  text("si quieres jugar de nuevo", 250, 265);

  textFont(letra, 18);
  textAlign(CENTER);
  text("Si quieres salir pulsa S", 390, 485);

  //Botón de reintentar: relleno, color de linea, dos elipses, letra, color, centrar, texto 
  fill(#98CBC2);
  stroke(#FFFFFF);
  ellipse(248, 390, 300, 120);
  ellipse(248, 390, 290, 110);
  textFont(letra, 32);
  fill(#FFFFFF);
  textAlign(CENTER);
  text("VOLVER A JUGAR", 250, 403);
}
  

// PANTALLA GAME OVER: letra, relleno de color segun el raton, alineacion, texto
void perdido() {

  textFont(letra, 60);
  fill(mouseX, mouseY, height);
  textAlign(CENTER);
  text("Has perdido", 250, 120);

  textFont(letra, 40);
  fill(#FFFFFF);
  textAlign(CENTER);
  text("Dale al botón", 250, 220);
  textFont(letra, 40);
  textAlign(CENTER);
  text("e inténtalo de nuevo", 250, 265);

  textFont(letra, 18);
  textAlign(CENTER);
  text("Si quieres salir pulsa S", 390, 485);

  //Botón de reintentar: relleno, color de linea, dos elipses, letra, color, centrar, texto 
  fill(#98CBC2);
  stroke(#FFFFFF);
  ellipse(248, 390, 300, 120);
  ellipse(248, 390, 290, 110);
  textFont(letra, 40);
  fill(#FFFFFF);
  textAlign(CENTER);
  text("REINTENTAR", 250, 403);
}


//PULSAR
void mouseClicked() {

  if (mouseX>160 && mouseX<370 && mouseY<430 && mouseY>350 && pantalla==0 ) { // click en la elipse que pone PLAY
  
    pantalla=1;
    
  }
  if (mouseX>100 && mouseX<390 && mouseY<450 && mouseY>340 && pantalla==2) { // click en la figura de reiniciar
  
   vidas=3;
   puntos=0;
   pantalla=1;
   crearBloque();
  }
   if (mouseX>100 && mouseX<390 && mouseY<450 && mouseY>340 && pantalla==3) { 
   
    vidas=3;
    puntos=0;
    pantalla=1;
    iniciovariables();
    crearBloque();
  }
}

//BLOQUES
class Bloque {

  //Variables de los bloques
  int x, y, z, anchoBloque, altoBloque;
  float r;
  float g;
  float b;
  Bloque (int xPosBloque, int yPosBloque, int estadoBloque) { //constructor
    x=xPosBloque;
    y=yPosBloque;
    z=estadoBloque;
    anchoBloque=35;
    altoBloque=20;
  }

  //DIBUJAR LOS BLOQUES
  void dibujar() {
    if (z==1) {
      fill(#FFFFFF);
      stroke(#ED62A3);
      strokeWeight(2);
      rectMode(CENTER);
      rect(x, y, anchoBloque, altoBloque);
    }
  }

  //ELIMINAR BLOQUES
  void desaparecer() {
    if (posxbola > x-anchoBloque/2-radio && posxbola < x+anchoBloque/2+radio && posybola > y-altoBloque/2-radio && posybola < y +altoBloque/2+radio && z==1) {
      z=0;
      velybola= velybola*(-1);
      puntos++;
    }
  }
}


//POSICIÓN DE LOS BLOQUES EN FILAS Y COLUMNAS
void crearBloque() {
  for (int i=0; i< miBloque1.length; i++) {
    miBloque1[i]= new Bloque(i*width/numBloques+width/(2*numBloques), height/7, 1);
  }
  
}


//DIBUJAR BLOQUES
void dibujarBloque() {
  for (int i=0; i< miBloque1.length; i ++) {
    miBloque1[i].dibujar();
    miBloque1[i].desaparecer();
  }
  
}

void terminarPartida() {
  if (posybola>=height) {
    vidas=vidas-1;
    iniciovariables();
  }
  if (vidas==0)  pantalla=2;
  if (puntos==5) pantalla=3;

}
  
void keyPressed() { //pulsar S para salir
  switch (key) {
  case 's': 
    if (pantalla == 2||pantalla==3) { 
      exit(); 
      break;
    }
  }
}