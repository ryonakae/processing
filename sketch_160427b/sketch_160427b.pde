float noiseX = random(10);
float noiseY = random(10);
float noiseR = random(10);
float noiseStepX = 0.0005;
float noiseStepY = 0.001;
float noiseStepR = 0.00001;
float x, y, angle;
float scale = 300;

void setup(){
  size(1152, 768, P2D);
  colorMode(HSB, 360, 100, 100, 100);
  background(0, 0, 100, 100);
  smooth(8);
  frameRate(60);
}

void draw(){
  translate(width/2, height/2);
  noFill();
  stroke(0, 0, 0, 20);
  strokeWeight(0.2);

  pushMatrix();
    angle = radians(frameCount * 0.005);
    rotate(map(sin(angle) * noise(noiseR), -1, 1, -180, 180));

    beginShape();
      for(int i = 0; i < 4; i++){
        x = scale * cos(radians(360*i/4)) + map(noise(noiseX + i*100), 0, 1, -width/2, width/2);
        y = scale * sin(radians(360*i/4)) + map(noise(noiseY + i*100), 0, 1, -height/2, height/2);
        // vertex(x, y);
        curveVertex(x, y);
        noiseX += noiseStepX;
        noiseY += noiseStepY;
      }
    endShape(CLOSE);

    noiseR += noiseStepR;
  popMatrix();
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
  rect(-width/2, -height/2, width, height);
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