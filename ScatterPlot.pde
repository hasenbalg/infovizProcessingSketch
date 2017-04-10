Plot plot;

void setup(){
  size(400, 400);  // size always goes first!
  surface.setResizable(true);
  plot = new Plot("iris.csv");
}

void draw(){
  plot.draw();
}