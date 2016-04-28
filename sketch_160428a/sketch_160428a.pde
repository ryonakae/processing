class Walker {
  int x, y, z, scale, step;

  Walker(int _x, int _y, int _z, int _scale, int _step){
    x = _x;
    y = _y;
    z = _z;
    scale = _scale;
    step = _step;
  }

  void display(){
    stroke(0, 0, 100, 20);
    strokeWeight(0.5);
    blendMode(ADD);
    point(x, y, z);
  }

  void step(){
    float choice = random(0, 6);
    if(choice < 1) {
      x += step;
    } else if(choice >= 1 && choice < 2) {
      x -= step;
    } else if(choice >= 2 && choice < 3) {
      y += step;
    } else if(choice >= 3 && choice < 4) {
      y -= step;
    } else if(choice >= 4 && choice < 5) {
      z += step;
    } else {
      z -= step;
    }

    // 衝突判定
    if(x > scale/2){
      x -= step;
    } else if(x < -scale/2){
      x += step;
    }
    if(y > scale/2){
      y -= step;
    } else if(y < -scale/2){
      y += step;
    }
    if(z > scale/2){
      z -= step;
    } else if(z < -scale/2){
      z += step;
    }
  }
}

Walker walker1;
Walker walker2;
int fromX, fromY, fromZ, toX, toY, toZ;
int pointStep = 50;
int boxScale = 500;
float lineLength = 100;
float distance;

void setup(){
  size(1152, 768, P3D);
  colorMode(HSB, 360, 100, 100, 100);
  background(0, 0, 0, 100);
  smooth(8);
  frameRate(60);

  int x1 = int(random(0, boxScale/pointStep)) * pointStep;
  int y1 = int(random(0, boxScale/pointStep)) * pointStep;
  int z1 = int(random(0, boxScale/pointStep)) * pointStep;
  int x2 = int(random(0, boxScale/pointStep)) * pointStep;
  int y2 = int(random(0, boxScale/pointStep)) * pointStep;
  int z2 = int(random(0, boxScale/pointStep)) * pointStep;

  println(x1, y1, z1, x2, y2, z2);

  walker1 = new Walker(x1, y1, z1, boxScale, pointStep);
  walker2 = new Walker(x2, y2, z2, boxScale, pointStep);
}

void setPoint(){
  walker1.step();
  walker2.step();

  if(walker1.x == walker2.x || walker1.y == walker2.y || walker1.z == walker2.z){
    fromX = walker1.x;
    fromY = walker1.y;
    fromZ = walker1.z;
    toX = walker2.x;
    toY = walker2.y;
    toZ = walker2.z;
  } else {
    setPoint();
  }
}

void draw(){
  // 原点移動
  translate(width/2, height/2);
  // カメラ
  camera(500, 400, 800, 0, -50, 0, 0, 1, 0);

  noFill();
  stroke(0, 0, 10, 10);
  blendMode(ADD);
  strokeWeight(0.5);
  box(boxScale);

  setPoint();

  noFill();
  stroke(0, 0, 100, 20);
  strokeWeight(0.5);
  blendMode(ADD);

  distance = dist(fromX, fromY, fromZ, toX, toY, toZ);
  if(distance >= lineLength){
    line(fromX, fromY, fromZ, toX, toY, toZ);
  }
}