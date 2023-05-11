import java.util.ArrayList;
import java.util.Random;
PGraphics pg;

float playerX = 0;
float playerY = 0;

float playerSize = 40;
float playerSpeed = 3; // pixels per frame
float playerXSpeed = 0;
float playerYSpeed = 0;

PImage playerImage; // declare a variable to hold the player image
float playerAngle = 0; // player angle in radians

// Voronoi point class to store position and index
class VoronoiPoint {
  float x, y;
  int index;
  
  VoronoiPoint(float x, float y, int index) {
    this.x = x;
    this.y = y;
    this.index = index;
  }
}

// Main class
void setup() {
  size(1920, 1080);
  surface.setTitle("Voronoi Generator Game");
  fullScreen();
  //surface.setResizable(true);
  //surface.setLocation(100, 100);
  background(255);

  playerImage = loadImage("images/player.png"); // load the player image
  playerX = width/2;
  playerY = height/2;
  pg = createGraphics(width, height);
  


  
  // Generate random Voronoi points
  ArrayList<VoronoiPoint> points = generatePoints(1500, width, height);
  
  // Generate Voronoi diagram
  int[][] voronoi = generateVoronoi(points, width, height);
  
  // Assign colors to each region
  int numRegions = points.size();
  int[] regionColors = new int[numRegions];
  int[] colorPalette = {color(128, 138, 127), color(117,117,116), color(194, 180, 159), color(173, 140, 137),color(120, 143, 150),color(166, 166, 166)};
  for (int i = 0; i < numRegions; i++) {
    int regionColorIndex = voronoi[(int)points.get(i).x][(int)points.get(i).y] % 6;
    regionColors[i] = colorPalette[regionColorIndex];
  }
  
  // Draw Voronoi diagram with noise
  pg.beginDraw();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int pointIndex = voronoi[x][y];
      
      if (points.get(pointIndex).x > width*((float)425/1000)  && points.get(pointIndex).x < width*((float)575/1000) && points.get(pointIndex).y > height*((float)425/1000) && points.get(pointIndex).y < height*((float)575/1000)) {
        pg.stroke(201, 242, 255);
      } else {
        pg.stroke(regionColors[pointIndex]);
        //pg.stroke(color(pointIndex,0,0));
        //println(pointIndex);
        
      }
      pg.point(x, y);
  }
    }
              // randomly generate squares
        int numSquares = 40;
        for (int i = 0; i < numSquares; i++) {
          float xx = random(width); // random x position
          float yy = random(height); // random y position
          float size = random(20, 20); // random size between 20 and 50 pixels
          pg.fill(color(255, 216, 25)); // random fill color
          pg.rect(xx, yy, size, size); // draw the square
  }
  pg.endDraw();
}

// Generate random Voronoi points with indices
ArrayList<VoronoiPoint> generatePoints(int numPoints, int maxX, int maxY) {
  ArrayList<VoronoiPoint> points = new ArrayList<VoronoiPoint>();
  Random rand = new Random();
  for (int i = 0; i < numPoints; i++) {
    float x = rand.nextInt(maxX);
    float y = rand.nextInt(maxY);
    points.add(new VoronoiPoint(x, y, i));
  }
  return points;
}

// Generate Voronoi diagram
int[][] generateVoronoi(ArrayList<VoronoiPoint> points, int maxX, int maxY) {
  int[][] voronoi = new int[maxX][maxY];
  for (int x = 0; x < maxX; x++) {
    for (int y = 0; y < maxY; y++) {
      int minIndex = -1;
      float minDist = Float.MAX_VALUE;
      for (int i = 0; i < points.size(); i++) {
        float dist = dist(x, y, points.get(i).x, points.get(i).y);
        if (dist < minDist) {
          minDist = dist;
          minIndex = i;
        }
      }
      voronoi[x][y] = minIndex;
    }
  }
  return voronoi;
}

void draw() {
  // update the player's position based on the current speed
  image(pg,0,0);
  color currentColor = pg.get((int)playerX, (int)playerY);
  color openSpace = color(201, 242, 255);

  println(currentColor);
  if (red(currentColor) != red(openSpace)) {
       playerXSpeed = playerXSpeed * (-1);
       playerYSpeed = playerYSpeed * (-1);
  }
  playerX += playerXSpeed;
  playerY += playerYSpeed;

  // draw the player in the new position with the player color
  // draw the player image at the current position and angle
  pushMatrix();
  translate(playerX, playerY);
  rotate(playerAngle);
  image(playerImage, -playerSize/2, -playerSize/2, playerSize, playerSize);
  popMatrix();
  //fill(80, 80, 80); 
  //ellipse(playerX - playerSize/2, playerY - playerSize/2, playerSize, playerSize);
  
    // draw black borders around the edges of the screen
  stroke(0); // set stroke color to black
  strokeWeight(20); // set stroke weight to 10 pixels
  line(0, 0, width, 0); // top edge
  line(width, 0, width, height); // right edge
  line(width, height, 0, height); // bottom edge
  line(0, height, 0, 0); // left edge
}

void keyPressed() {
      if (keyCode == LEFT) {
      playerXSpeed = -playerSpeed;
    } else if (keyCode == RIGHT) {
      playerXSpeed = playerSpeed;
    }
    if (keyCode == UP) {
      playerYSpeed = -playerSpeed;
      if (playerXSpeed == 0) {
      } else {
      }
    } else if (keyCode == DOWN) {
      playerYSpeed = playerSpeed;
      if (playerXSpeed == 0) {
    }
    }
    
  // calculate the player angle based on the current speed
  if (playerXSpeed != 0 || playerYSpeed != 0) {
    playerAngle = atan2(playerYSpeed, playerXSpeed);
  }
  
  // draw the player image at the current position and angle
  pushMatrix();
  translate(playerX, playerY);
  rotate(playerAngle);
  image(playerImage, -playerSize/2, -playerSize/2, playerSize, playerSize);
  popMatrix();
}

void keyReleased() {
  if (keyCode == LEFT || keyCode == RIGHT) {
    playerXSpeed = 0;
  } else if (keyCode == UP || keyCode == DOWN) {
    playerYSpeed = 0;
  }
}
