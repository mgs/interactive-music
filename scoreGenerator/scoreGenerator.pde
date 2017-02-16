int timeClock = 0;
float rows = 32;
float columns = 32;
float xCounter, yCounter;
float columnWidth, rowHeight;
PVector currentNote = new PVector();
ArrayList<PVector> score = new ArrayList();
boolean loopMode = false;
int numOfStepsPerFrame = 1;
int minSize = 15;
int alpha = 10;
boolean playerMode = false;

char[] noteName = {'A', 'B', 'C', 'D', 'E', 'F', 'G'};
int[] noteNum = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};

void setup() {  
  size(800, 800, P3D);
  noStroke();
  smooth(4);
  columnWidth = width/columns;
  rowHeight = height/rows;
  colorMode(HSB);
  background(0);
  frameRate(60);
}

void draw() {
  fill(0, alpha);
  rectMode(CORNER);
  rect(0, 0, width, height);
  if (playerMode) {
    background(0);
    for (int i = 0; i < numOfStepsPerFrame; i++) {
      if (loopMode) {
        currentNote = score.get(int(xCounter));
        fill(score.get(int(xCounter)).x, score.get(int(xCounter)).y, 255-score.get(int(xCounter)).z);
      } else {
        currentNote = makeNote();
        score.add(currentNote);
        fill(score.get(timeClock).x, score.get(timeClock).y, 255-score.get(timeClock).z);
        timeClock++;
      }
      //rectMode(CENTER);
      //if (xCounter % 2 == 0) {
      //  rect(0, 0, width/2, height/2);
      //}
      rectMode(CENTER);
      rect(width/2, height/2, (minSize*10)+currentNote.z, (minSize*10)+currentNote.z);
      nextStep();
    }
  } else {       
    for (int i = 0; i < numOfStepsPerFrame; i++) {
      if (loopMode) {
        currentNote = score.get(int(xCounter));
        fill(score.get(int(xCounter)).x, score.get(int(xCounter)).y, 255-score.get(int(xCounter)).z);
      } else {
        currentNote = makeNote();
        score.add(currentNote);
        fill(score.get(timeClock).x, score.get(timeClock).y, 255-score.get(timeClock).z);
        timeClock++;
      }
      rectMode(CENTER);
      //if (xCounter % 2 == 0) {
      //  rect(xCounter*columnWidth, yCounter*rowHeight, columnWidth, rowHeight);
      //}
      rect(xCounter*columnWidth, yCounter*rowHeight, minSize+currentNote.z, minSize+currentNote.z);
      nextStep();
    }
  }
}

PVector makeNote() {
  return new PVector(int(random(110, 200)), int(random(200, 255)), int(random(15)));
}

void nextStep() {
  if (xCounter >= columns) {
    xCounter = 0;
    yCounter++;
  } else {
    xCounter++;
  }
  if (yCounter > rows) {
    yCounter = 0;
  }
}

void keyPressed() {
  if (key == CODED) {
    switch(keyCode) {
    case RIGHT:
      alpha++;
      break;
    case LEFT:
      alpha--;
      break;
    case UP:
      minSize++;
      break;
    case DOWN:
      minSize--;
      break;
    }
  } else {
    switch(key) {
    case ' ':
      background(0);
      playerMode = !playerMode;
      if (playerMode) {
        frameRate(1);
      } else {
        frameRate(60);
      }
      break;
    case 's':
      println(score);
      break;
    case 'l':
      loopMode = !loopMode;
      println("loopMode is " + loopMode);
      break;
    case '+':
      numOfStepsPerFrame++;
      break;
    case '-':
      numOfStepsPerFrame--;
      break;
    }
  }
}