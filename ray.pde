class ray {
  PVector pos = new PVector (width/4, height/2);
  PVector dir;
  PVector vel = new PVector (0, 0);
  float start;
  float mag = 10;
  PVector closest = null;
  float heading = 0;
  boolean lefting, righting;
  PVector top = PVector.fromAngle(fov/2);
  PVector bot = PVector.fromAngle(-fov/2);

  ray(float x, float y, float a) {
    pos.x = x;
    pos.y = y;
    start = a;
    dir = PVector.fromAngle(a);
    dir.setMag(mag);
  }

  void update(float xx, float yy, float angle) {
    float x = constrain(xx, 0, width/2);
    float y = constrain(yy, 0, height);
    pos.set(x, y);
    push();
    if (righting) {
      dir = PVector.fromAngle(start);
      start+=angle;
    } else if (lefting) {
      dir = PVector.fromAngle(start);
      start-=angle;
    } 
    pop();
    pos.add(vel);
  }

  void show(float angle) {
    push();

    fill(255, 0, 0);
    ellipse(width/4, height/2, 16, 16);
    dir = PVector.fromAngle(angle);
    pop();
  }

  void collideWall(ArrayList<boundary> walls) {
    float record = 999999999;
    for (boundary b : walls) {
      PVector intPoint = null;
      float intPointx;
      float intPointy;

      float x1 = b.a.x;
      float y1 = b.a.y;
      float x2 = b.b.x;
      float y2 = b.b.y;

      float x3 = pos.x;
      float y3 = pos.y;
      float x4 = pos.x + dir.x;
      float y4 = pos.y + dir.y;

      float den = ((x1 - x2) * (y3 - y4)) - ((y1 - y2) * (x3 - x4));
      if (den == 0) {
        return;
      }

      float t = (((x1 -x3) * (y3-y4)) - ((y1 - y3) * (x3 - x4)))/den;
      float u = -(((x1-x2) * (y1-y3)) - ((y1 - y2) * (x1 - x3)))/den;

      if (t >= 0 && t <= 1 && u <= 1) {
        intPointx = x1 + t * (x2 - x1);
        intPointy = y1 + t * (y2 - y1); 
        intPoint = new PVector (intPointx, intPointy);
      } 
      if (intPoint != null) {
        float d = PVector.dist(pos, intPoint);
        if (d < record) {
          record = d;
          closest = intPoint;
        }
      }
    }
    if (closest != null) {
      push();
      scene.add(record);
      stroke(255, 0, 0);
      line(pos.x, pos.y, closest.x, closest.y);
      pop();
    }
  }

  void view(float x, float y) {
    push();
    stroke(0, 0, 255);
    pos.set(x, y);
    pop();
  }
}
