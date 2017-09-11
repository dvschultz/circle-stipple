PImage img;
PGraphics buffer;
int i = 0;

int rInc = 4; // this is the radius difference between rings 
String file = "face.png"; // image file
int fileWidth = 960; //set to image width
int fileHeight = 960; //set to image height
boolean posterize = true; //posterization might give you better results on tricky images

void settings() {
	size(fileWidth,fileHeight);
}

void setup() {
  img = loadImage(file);
  buffer = createGraphics(width, height);
  drawBuffer(buffer,img);
  buffer.loadPixels();

	background(#FFFFFF);
	noFill();
	stroke(#000000);
	doIt();
}

void drawBuffer(PGraphics pg,PImage img) {
	pg.beginDraw();
	pg.background(#FFFFFF);
	pg.image(img, 0, 0, buffer.width, buffer.height);
	pg.filter(GRAY);
	if(posterize) pg.filter(POSTERIZE,4);
	pg.endDraw();
}

void doIt() {
	float angle,x,y;
	for(int r = rInc; r <= width; r+=rInc) {
		
		float seg = float(r)*5;
		float a = 360.0/seg;

		for (float s = 0; s < 360.0; s+=a) {
			angle = radians(s);
			x = width/2 + (r * cos(angle));
			y = height/2 + (r * sin(angle));

			if (x <= width && x >= 0 && y >= 0 && y < height ) {
				float c = getC(x,y);
				if(c < 1) {
					point(x,y);	
					i++;
				} else if(c <= 50.0) {
					if(i%2 == 0) {
						point(x,y);	
					}
					i++;
				} else if(c <= 85.0) {
					if(i%3 == 0) {
						point(x,y);	
					}
					i++;
				} else if(c <= 170.0) {
					if(i%6 == 0) {
						point(x,y);	
					}
					i++;
				} else if(c <= 205.0) {
					if(i%9 == 0) {
						point(x,y);	
					}
					i++;
				}
			}			
		}
		
	}
}

float getC(float x, float y) {
	int roundX =  (int) floor(x);
	int roundY = (int) floor(y);
	float bright = brightness(buffer.pixels[roundY*buffer.width + roundX]);
	return bright;
}
