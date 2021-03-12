private int circleRadius;
private RGBPreset colorValue; 
private RGBPreset backgroundColor;
private ShapeType currentShape;

private enum RGBPreset {

  PURE_RED(255, 0, 0),
  PURE_GREEN(0, 255, 0),
  PURE_BLUE(0, 0, 255),
  PURE_WHITE(255, 255, 255),
  PURE_BLACK(0, 0, 0);
  
  int r, g, b;
  
  int getR() { return r; }
  int getG() { return g; }
  int getB() { return b; }
  
  private RGBPreset(int r, int g, int b) {
      this.r = r;
      this.g = g;
      this.b = b;
  }
  
}

private enum ShapeType {
  SQUARE, CIRCLE
}

void settings() {
  size(800, 600);
  smooth(8);
  circleRadius = 25;
  colorValue = RGBPreset.PURE_WHITE;
  backgroundColor = RGBPreset.PURE_WHITE;
  currentShape = ShapeType.CIRCLE;
}

void setup() {
  frameRate(60);
  ellipseMode(RADIUS);
  rectMode(RADIUS);
}

void draw() {
  background(backgroundColor.getR(), backgroundColor.getG(), backgroundColor.getB()); 

  if (keyPressed) {    
    switch(key) {
      
      // Handle color changing
      case 'r': {
        colorValue = RGBPreset.PURE_RED;
        break;
      }
      
      case 'g': {
        colorValue = RGBPreset.PURE_GREEN;
        break;
      }
      
      case 'b': {
       colorValue = RGBPreset.PURE_BLUE;
       break;
     }
     
     // Handle shape changing
     case 's': {
       currentShape = ShapeType.SQUARE;
       break;
     }
     
     case 'c': {
       currentShape = ShapeType.CIRCLE;
     }
    }
    
    fill(colorValue.getR(), colorValue.getG(), colorValue.getB());
  }
  
  switch (currentShape) {
   
    case CIRCLE: {
      ellipse(mouseX, mouseY, circleRadius, circleRadius);
      break;
    }
    
    case SQUARE: {
      rect( mouseX, mouseY, circleRadius, circleRadius);
    }
    
  }
  

}

void mouseClicked() {
  switch (mouseButton) {
    case LEFT: {
      backgroundColor = RGBPreset.PURE_BLACK;
      break;
    }
    
    case RIGHT: {
      backgroundColor = RGBPreset.PURE_WHITE;
      break;
    }
   
  }

}
