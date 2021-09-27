class box {
  PVector pos;
  int r;
  int texture;
  int id;

  PVector p1, p2, p3, p4;

  box(int r_, float x, float y, int texture_, int id_) {
    pos = new PVector(x, y);
    r = r_;
    texture = texture_;
    id = id_;

    p1 = new PVector(pos.x, pos.y);
    p2 = new PVector(pos.x+r*2, pos.y);
    p3 = new PVector(pos.x+r*2, pos.y+r*2);
    p4 = new PVector(pos.x, pos.y+r*2);

    walls.add(new wall(p1, p2, texture, id));
    walls.add(new wall(p2, p3, texture, id));
    walls.add(new wall(p3, p4, texture, id));
    walls.add(new wall(p4, p1, texture, id));
  } 


  void show() {
    push();
    fill(textureSelect());
    noStroke();
    rect(pos.x, pos.y, r*2, r*2);
    pop();
  }


  color textureSelect() {
    color c = color(0);
    if (texture == 1) {
      c = color(0, 255, 255, 150);
    } else if (texture == 2) {
      c = color(0, 255, 0, 150);
    } else if (texture == 3) {
      c = color(0, 0, 255, 150);
    }
    return c;
  }
}
