// FLOR CORREA LÓPEZ 
// 2ºBACH.B
// IES VICENTE ALEIXANDRE

//BOLA
int posxbola=width/2; // posicion mitad del ancho
int posybola=height/2; // posicion mitad del alto
int velxbola= 1; // velocidad en x
int velybola=3; // velocidad en y
int radio=12; // radio de la bola

//PALA
int altopala=15; //alto de la barra
int anchopala=100; // ancho de la barra
int posypala=450; // posicion en y de la barra
int posxpala=0; // posicion de la pala en X

PFont letra; // letra de inicio

int pantalla=0; // distintas pantallas de juego


void setup() {
  size (500, 500); // pantalla de juego
  colorMode(HSB, height, height, height); // paleta de colores
  letra= createFont("ColonnaMT-48", 30); // tipo de letra que queremos
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
  }
}


void inicio() {

  //ENUNCIADO PONG: tipo de letra, colorear, centrar, escribir texto
  textFont(letra, 80);  
  fill(mouseX, mouseY, width);
  textAlign(CENTER);
  text("PONG", 250, 150);


  // ENUNCIADO INSTRUCCIONES:  tipo de letra, colorear, centrar, escribir texto
  textFont(letra, 35);
  fill(mouseX, width);
  textAlign(CENTER);
  text("INSTRUCCIONES:", 250, 270);
  textFont(letra, 30);
  text ("Utiliza el ratón para mover la pala", 250, 320);

  //ENUNCIADO PLAY:  color de fondo de la elipse,crear elipse, tipo de letra, colorear, centrar, escribir texto
  fill(#98CBC2); 
  ellipse(248, 390, 180, 70);
  textFont(letra, 40); 
  fill(#FFFFFF);
  textAlign(CENTER);
  text("PLAY", 250, 403);
}

void juego() {
  dibujarbola(); //dibujar la bola
  dibujarpala(); // dibujar la pala
  moverbola(); // movimiento bola
  moverpala(); // movimiento pala
  rebotes(); // rebotes pantalla y pala
}

// DIBUJAR BOLA: linea de color blanco, relleno, grosor de linea, dibujo de la pala
void dibujarpala() {
  stroke(#FFFFFF); 
  fill(#ED62A3);
  strokeWeight(2);
  rect(posxpala, posypala, anchopala, altopala);
}
//DIBUJAR PALA: linea de color blanco, relleno, grosor de linea, dibujo de la bola
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
  posxpala=mouseX -(25/2); // posicion de la pala en X
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
  if (posxbola >= posxpala && posxbola <= posxpala+anchopala) {
    if (posybola+radio >= posypala && posybola <= posypala) {
      velybola = velybola*-1;
    }
  }
  // GAME OVER
  if (posybola+radio>=height) {
    pantalla=2;
  }
}


// PANTALLA GAME OVER: letra, relleno de color segun el raton, alineacion, texto
void perdido() {
  textFont(letra, 70);
  fill(mouseX, mouseY, height);
  textAlign(CENTER);
  text("HAS PERDIDO", 250, 250);
}



//PULSAR EN PLAY
void mouseClicked() { // click en la elipse que pone PLAY
  if (mouseX>160 && mouseX<340 && mouseY<450 && mouseY>350 && pantalla==0 ) {
    pantalla=1;
  }
}
