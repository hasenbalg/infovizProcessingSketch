class Plot {
  private int margin = 10;
  private Table table;
  private String[] fields, chosen_fields;
  private PVector min, max;

  private ArrayList<PVector> values;

  Plot(String path) {
    table = loadTable(path, "header");
    println(table.getRowCount() + " total rows in table"); 

    values = new ArrayList<PVector>();

    chosen_fields = new String[]{"sepal_length", "sepal_width"};
    get_values();

    get_min_max();
  }

  public void draw() {
    draw_axis();
    draw_points();
  }

  public void draw_axis() {
    pushMatrix();
    stroke(000);
    text(chosen_fields[1], margin, margin); 
    line(0, height, 0, 0);
    translate(0, height-1);
    text(chosen_fields[0], width-margin, - margin); 
    line(0, 0, width, 0);
    popMatrix();
  }

  public void get_values() {
    for (TableRow row : table.rows()) {
      values.add(
        new PVector(
        row.getFloat(chosen_fields[0]), 
        row.getFloat(chosen_fields[1])
        )
        );
    }
  }

  public void draw_points() {

    for (PVector point : values) {
      pushMatrix();
      translate((point.x/(max.x-min.x))*width, (point.y/(max.y-min.y))*height);
      println("x:" + (point.x/(max.x-min.x))*width + " y:" + (point.y/(max.y-min.y))*height);
      fill(000);
      ellipse(0, 0, 2, 2);
      popMatrix();
    }
  }

  private void get_min_max() {
    max = new PVector(MIN_FLOAT, MIN_FLOAT);
    min = new PVector(MAX_FLOAT, MAX_FLOAT);

    for (PVector p : values) {
      if (p.x > max.x) {
        max.x = p.x;
      }
      if (p.x < min.x) {
        min.x = p.x;
      }
      if (p.y > max.y) {
        max.y = p.y;
      }
      if (p.y < min.y) {
        min.y = p.y;
      }
    }
    print(min);
    print(max);
  }


  public void set_margin(int margin) {
    this.margin = margin;
  }
}