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
    draw_Y_scale();
    
    translate(0, height-1);
    text(chosen_fields[0], width-margin, - margin); 
    line(0, 0, width, 0);
    draw_X_scale();
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
      fill(color(255, 204, 0));
      stroke(0);
      translate(map(point.x, min.x, max.x, 0, width), map(point.y, min.y, max.y, height, 0));
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
    min.x = floor(min.x);
    min.y = floor(min.y);
    max.x = ceil(max.x);
    max.y = ceil(max.y);
    print(min);
    print(max);
  }

  private void draw_X_scale() {
    for (float i = min.x; i <= max.x; i += .1) {
      i = round( i * 100.0f ) / 100.0f;// misterioeses nachrunden      
      if(i - (int)i == 0){
        line(
        map(i, min.x, max.x, 0, width), 0, 
        map(i, min.x, max.x, 0, width), -margin * 2
        );
       text(String.format("%.1f", i), map(i, min.x, max.x, 0, width), -margin * 2);
      }else{
        line(
          map(i, min.x, max.x, 0, width), 0, 
          map(i, min.x, max.x, 0, width), -margin
          );
      }
    }
  }

  public void draw_Y_scale() {
    for (float i = min.y; i < max.y; i += .1) {
      i = round( i * 100.0f ) / 100.0f;// misterioeses nachrunden      

      if(i - (int)i == 0){
         line(
        margin * 2, 
        map(i, min.y, max.y, height, 0), 
        0, 
        map(i, min.y, max.y, height, 0)
        );
        text(String.format("%.1f", i), margin * 2, map(i, min.y, max.y, height, 0));
      }else{
       line(
        margin, 
        map(i, min.y, max.y, height, 0), 
        -margin, 
        map(i, min.y, max.y, height, 0)
        );
      }
      
     
    }
  }


  public void set_margin(int margin) {
    this.margin = margin;
  }
}