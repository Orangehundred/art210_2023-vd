float zoom;
planet sun = new planet();
planet mercury = new planet();
planet venus = new planet();
planet earth = new planet();
planet mars = new planet();
planet jupiter = new planet();
planet saturn = new planet();
planet uranus = new planet();
planet neptune = new planet();
planet pluto = new planet();

 void setup()
 {
size(1200,800);

sun.dist = 0;
sun.size = 40;
sun.col = color(255,255,0);
mercury.dist = 57.9;
mercury.size = 5;
mercury.col = color(100,100,100);
venus.dist = 108.2/3;
venus.size = 12;
venus.col = color(200,200,0);
earth.dist = 149.6/3;
earth.size = 12;
earth.col = color(0,150,100);
mars.dist = 228/3;
mars.size = 6;
mars.col = color(255,150,50);
jupiter.dist = 778.5/3;
jupiter.size = 142;
jupiter.col = color(255,200,50);
saturn.dist = 1432.0/3;
saturn.size = 120;
saturn.speed = 0.97;
saturn.col = color(230,230,0);
uranus.dist = 2867.0/5;
uranus.size = 50;
uranus.col = color(0,200,240);
neptune.dist = 4515.0/6;
neptune.col = color(0,0,250);
neptune.size = 50;
pluto.dist = 5906.4/6;
pluto.col = color(255,0,240);
 }

 void draw()
 {
   noStroke(); //get rid of countour lines
   fill(0,0,0,5); //paint it black
   rect(0,0,width,height);
   translate(width/2,height/2);
   scale(zoom);

  sun.draw();
  sun.update();
  mercury.draw();
  mercury.update();
  venus.draw();
  venus.update();
    earth.draw();
  earth.update();
  mars.draw();
  mars.update();
    jupiter.draw();
  jupiter.update();
    saturn.draw();
  saturn.update();
    uranus.draw();
  uranus.update();
    neptune.draw();
  neptune.update();
    pluto.draw();
  pluto.update();
   
 }
 
 void mouseWheel(MouseEvent event)
 {
   float e = event.getCount();
   zoom = zoom + (e/10.0);
 }
