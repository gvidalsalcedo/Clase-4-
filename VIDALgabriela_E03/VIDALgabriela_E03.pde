int numStars = 6; 
float[] starX = new float[numStars];
float[] starY = new float[numStars];
float[] starRotation = new float[numStars];
float[] starOffset = new float[numStars];

float waveOffset = 0;
float[] nubeX = {50, 200, 350}; // Posiciones iniciales de nubes
float nubeSpeed = 0.5;

void setup() {
  size(500, 500);
  noStroke();
  colorMode(HSB, 360, 100, 100); // Modo de color HSB para transiciones suaves

  // Posiciones iniciales de las estrellas de mar
  for (int i = 0; i < numStars; i++) {
    starX[i] = random(50, width - 50);
    starY[i] = random(height / 2 + 80, height - 80); 
    starRotation[i] = random(TWO_PI);
    starOffset[i] = random(0, TWO_PI);
  }
}

void draw() {  
  // Fondo en tonos azules con un degradado sutil
  float skyColor = map(sin(frameCount * 0.01), -1, 1, 180, 210);
  background(skyColor, 50, 90);

  // Dibujar nubes en la parte superior
  for (int i = 0; i < nubeX.length; i++) {
    drawCloud(nubeX[i], 80);
    nubeX[i] += nubeSpeed;
    if (nubeX[i] > width) {
      nubeX[i] = -50; // Reinicia el ciclo de las nubes
    }
  }

  // Mar sin movimiento 
  fill(210, 80, 80);
  rect(0, height / 2, width, height / 2);

  // Olas
  for (int i = 0; i < width; i += 40) {
    float waveHeight = sin((i + waveOffset) * 0.1) * 10;
    fill(220, 80, 90);
    ellipse(i, height / 2 + waveHeight, 50, 20);
  }
  waveOffset += 2; // Movimiento de las olas

  // Estrella de mar
  for (int i = 0; i < numStars; i++) {
    float yOffset = sin(frameCount * 0.02 + starOffset[i]) * 5;
    drawRoundedStar(starX[i], starY[i] + yOffset, starRotation[i]); 
  }
}

// Estrellas de mar
void drawRoundedStar(float x, float y, float rotation) {
  pushMatrix();
  translate(x, y);
  rotate(rotation);

  fill(10, 80, 90); // Color coral
  beginShape();
  for (int i = 0; i < 10; i++) {
    float angle = TWO_PI / 10 * i;
    float r = (i % 2 == 0) ? 20 : 12; // Puntas redondeadas más suaves
    float sx = cos(angle) * r;
    float sy = sin(angle) * r;
    curveVertex(sx, sy);
  }
  endShape(CLOSE);
  
  popMatrix();
}

// Nubes
void drawCloud(float x, float y) {
  fill(0, 0, 100, 150); // Blanco con opacidad
  ellipse(x, y, 50, 30);
  ellipse(x + 20, y - 10, 60, 40);
  ellipse(x + 40, y, 50, 30);
}
