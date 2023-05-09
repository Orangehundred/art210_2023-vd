import java.util.ArrayList;
import java.util.Random;
PGraphics pg;

float playerX = 0;
float playerY = 0;

float playerSize = 15;
float playerSpeed = 2; // pixels per frame
float playerXSpeed = 0;
float playerYSpeed = 0;

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
  size(1280, 720);
  surface.setTitle("Voronoi Generator Game");
  surface.setResizable(true);
  surface.setLocation(100, 100);
  background(255);

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
  int[] colorPalette = {color(128, 138, 127), color(117,117,116), color(194, 180, 159), color(173, 140, 137)};
  for (int i = 0; i < numRegions; i++) {
    int regionColorIndex = voronoi[(int)points.get(i).x][(int)points.get(i).y] % 4;
    regionColors[i] = colorPalette[regionColorIndex];
  }
  
  // Draw Voronoi diagram with noise
  pg.beginDraw();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int pointIndex = voronoi[x][y];

      if (points.get(pointIndex).x > width*((float)450/1000)  && points.get(pointIndex).x < width*((float)550/1000) && points.get(pointIndex).y > height*((float)450/1000) && points.get(pointIndex).y < height*((float)550/1000)) {
        pg.stroke(201, 242, 255);
      } else {
        pg.stroke(regionColors[pointIndex]);
        pg.stroke(color(pointIndex,0,0));
        //println(pointIndex);
        
      }
      pg.point(x, y);
    }
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
       //playerXSpeed = playerXSpeed * (-1);
       //playerYSpeed = playerYSpeed * (-1);
  }
  playerX += playerXSpeed;
  playerY += playerYSpeed;

  // draw the player in the new position with the player color
  fill(80, 80, 80); 
  ellipse(playerX - playerSize/2, playerY - playerSize/2, playerSize, playerSize);
}

void keyPressed() {
  if (keyCode == LEFT) {
    playerXSpeed = -playerSpeed;
  } else if (keyCode == RIGHT) {
    playerXSpeed = playerSpeed;
  } else if (keyCode == UP) {
    playerYSpeed = -playerSpeed;
  } else if (keyCode == DOWN) {
    playerYSpeed = playerSpeed;
  }
}

void keyReleased() {
  if (keyCode == LEFT || keyCode == RIGHT) {
    playerXSpeed = 0;
  } else if (keyCode == UP || keyCode == DOWN) {
    playerYSpeed = 0;
  }
}
