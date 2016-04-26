float noiseX = random(10);
float noiseY = random(10);
float noiseR = random(10);
float noiseStepX = 0.002;
float noiseStepY = 0.008;
float noiseStepR = 0.0001;
float fromX, fromY, toX, toY, angle;

void setup(){
  size(1152, 768, P2D);
  colorMode(HSB, 360, 100, 100, 100);
  background(0, 0, 100, 100);
  smooth(8);
  frameRate(60);
}

void draw(){
  translate(width/2, height/2);

  pushMatrix();
    beginShape();
      angle = radians(frameCount * 0.005);
      rotate(map(sin(angle) * noise(noiseR), -1, 1, -180, 180));
      fromX = map(noise(noiseX), 0, 1, -width/4, width/4);
      fromY = map(noise(noiseY), 0, 1, -height/4, height/4);
      toX = map(noise(noiseX), 0, 1, 0, width);
      toY = map(noise(noiseY), 0, 1, 0, height);
      noFill();
      stroke(0, 0, 0, 20);
      strokeWeight(0.2);
      rect(fromX, fromY, toX, toY);
    endShape(CLOSE);
  popMatrix();

  noiseX += noiseStepX;
  noiseY += noiseStepY;
  noiseR += noiseStepR;
}

// 左クリックでリセット、右クリックでスクショ保存
void mousePressed(){
  if(mouseButton == LEFT){
    reset();
  } else if (mouseButton == RIGHT){
    save();
  }
}

// リセット用関数
void reset(){
  fill(0, 0, 100, 100);
  blendMode(BLEND);
  noStroke();
  rect(-width/2, -height/2, width/2, height/2);
  redraw();
}

// スクショ保存用関数
import java.util.Date;
void save(){
  Date d = new Date();
  float time = d.getTime();
  String path = System.getProperty("user.home") + "/Desktop/screenshot" + time + ".png";
  save(path);
  println("screen saved." + path);
}