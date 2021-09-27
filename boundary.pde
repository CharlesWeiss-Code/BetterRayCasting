class boundary {
  PVector a = new PVector (0, 0);
  PVector b = new PVector (0, 0);

  boundary(float x1, float y1, float x2, float y2) {
    a.set(x1, y1);
    b.set(x2, y2);
  }

  void show() {
    push();
    stroke(255);
    line(a.x, a.y, b.x, b.y);
    pop();
  }
}
