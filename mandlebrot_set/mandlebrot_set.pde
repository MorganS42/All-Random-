float minX=-2;
float minY=-1;
float maxX=2;
float maxY=2;
float x=0;
float y=0;
float xtemp;
int maxIter=1000;
int colorScale=255;
int iter=0;
int scale;
float zoom=1;
float zx;
float zy;
float detail;
float colorR,colorG,colorB;
int colorHex;
String colorHexStr;
void setup() {
  fullScreen();
  background(255);
  scale=width/300;
  detail=0.25;
  colorMode(RGB,colorScale);
  zx=width/2;
  zy=height/2;
}

void draw() {
  background(255);
  //detail=detail-detail/4;
  for(float y0=minY; y0<maxY; y0+=0.01/scale) {
    for(float x0=minX; x0<maxX; x0+=0.01/scale) {
      x=0;
      y=0;
      iter=0;
      while(((x*x)+(y*y))<4 && iter<maxIter) {
        xtemp=((x*x)-(y*y))+x0;
        y=(2*x*y)+y0;
        x=xtemp;
        iter++;
        
      }
      //zx=mouseX;
      //zy=mouseY;
      colorHex = round(log(iter)/log(maxIter)*colorScale*colorScale*colorScale);
      colorHexStr = "000000" + str(colorHex);
      colorHexStr = colorHexStr.substring(colorHexStr.length()-6,colorHexStr.length());
      colorR=unhex(colorHexStr.substring(0,2));
      colorG=unhex(colorHexStr.substring(2,4));
      colorB=unhex(colorHexStr.substring(4,6));
      stroke(colorR,colorG,colorB);
//      point((x0+2)*100*scale+zx-width/2,(y0+1)*100*scale+zy-height/2);
      point((x0+2)*100*scale,(y0+1)*100*scale);
    }  
  }
}