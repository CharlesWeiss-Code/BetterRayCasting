ArrayList<ray> sun = new ArrayList<ray>();
ArrayList<boundary> walls = new ArrayList<boundary>();
ArrayList<Float> scene = new ArrayList<Float>();
float fov = radians(90);

void setup() {
  fullScreen();
  //size(1200, 600);
  for (float i = -fov/2; i < fov/2; i += radians(.5)) {
    sun.add(new ray(width/2, height/2, i));
  }
  for (int i = 0; i < 5; i ++) {
    walls.add(new boundary(random(width/2), random(height), random(width/2), random(height)));
  }
  // wall boundaries
  walls.add(new boundary(0, 0, 0, height));
  walls.add(new boundary(0, 0, width/2, 0));
  walls.add(new boundary(width/2, 0, width/2, height));
  walls.add(new boundary(0, height, width/2, height));
}

void draw() {
  background(0);
  rayStuff();
  wallStuff();
  drawScene();
  scene.clear();
  stroke(255);
  line(width/2, 0, width/2, height);
}

void rotate(float angle) {
  for (ray r : sun) {
    r.heading+=angle;
  }
}

void keyPressed() {
  for (ray r : sun) {
    if (key == 'a' || key == 'A') {
      r.righting = false;
      r.lefting = true;
    } else if (key == 'd' || key == 'D') {
      r.lefting = false;
      r.righting = true;
    }
  }
}

void keyReleased() {
  for (ray r : sun) {
    if (key == 'a' || key == 'A') {
      r.lefting = false;
    } else if (key == 'd' || key == 'D') {
      r.righting = false;
    }
  }
}

void rayStuff() {
  for (int i = 0; i < sun.size(); i++) {
    sun.get(i).collideWall(walls);
    //scene.append(sun.get(i).record);
    sun.get(i).update(mouseX, mouseY, .05);
  }
}

void wallStuff() {
  for (boundary wall : walls) {
    wall.show();
  }
}

void drawScene() {
  push();
  translate(width/2, height/2);
  float window2 = width/2;
  float w = window2/scene.size();
  float closeD = 200;
  for (int i = 0; i < scene.size(); i++) {
    float sceneSq = scene.get(i)*scene.get(i);
    float window2Sq = window2*window2;
    float b = map(sceneSq, 0, window2Sq*sqrt(2), 255, 0);
    float h = map(scene.get(i), 0, width/2*sqrt(2), height/1.5, 0);

    // color 
    if (scene.get(i) > closeD) {
      fill(b);
    } else if ( scene.get(i) < closeD) {
      color c2 = color(0, 0, 102);
      color start = color(b);
      float n = map(scene.get(i), 0, closeD, 1, 0);
      color end = lerpColor(start, c2, n);
      fill(end);
    } 

    rectMode(CENTER);
    noStroke();
    rect(i*w, 0, w+1, h);
  }
  pop();
}
