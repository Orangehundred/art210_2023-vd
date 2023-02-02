float _cx = 0.0; //Circle's position variable
float _cy = 0.0;
float _cdx = 10;
float _cdy = 5;


void setup()
{
 size(800,600);
}

void draw()
{
  noStroke();
  fill(0,0,0,10); //R,G,B, Alpha 
  rect(0,0,width,height);
  fill(random(0,255),random(0,255),random(255,255));
  circle(_cx, _cy, 40);  //drawing circle
  _cx = update(_cx,_cdx);
  _cy = update(_cy,_cdy);
  _cdx = check(_cx,_cdx, 0, width);
  _cdy = check(_cy, _cdy, 0, height);
 
}

float update(float value, float increment)
{
return(value + increment);
}

float check(float value, float delta, float lower_limit, float upper_limit)
{
   if (value > upper_limit || value < lower_limit)
   {
     return(delta * -1);
   }
   return(delta);
}
