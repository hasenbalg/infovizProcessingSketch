Plot plot;

void setup(){
  size(200,200,P2D);
  surface.setResizable(true);
  plot = new Plot("iris.csv");
}

void draw(){
  plot.draw();
}