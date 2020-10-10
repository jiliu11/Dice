int rows = 4;
int columns = 5;

//space between die
int dieSpace = 20;

int sum;

void setup()
{
  noLoop();
  size(1000, 1000);
}

void draw()
{
  background(0);
  
  sum = 0;
  
  //space between the edges of the canvas and the die
  int leftRightMarginSpace = (1000-(160 * columns + dieSpace * (columns - 1)))/2;
  
  //space between top of canvas and 200 units from the bottom
  //bottom part for words
  int upDownMarginSpace = (800-(160 * rows + 2 * (rows - 1)))/2;
  
  for( int a = 0; a < rows; a++)
  {
    for(int b = 0; b < columns; b++)
    {
       Die bobDie = new Die( b * (160 + dieSpace) + leftRightMarginSpace, a * (160 + dieSpace) + upDownMarginSpace);
       bobDie.roll();
       bobDie.show();
    }
  }
  
  //make dice add up number show up
  textSize(64);
  fill(255);
  textAlign(CENTER);
  text("total", 500, 860);
  text(sum, 500, 925);
}
void mousePressed()
{
  redraw();
}
class Die //models one single dice cube
{
  int diceNumber, myX, myY;
  
  //how thick die is
  int dieThick = 160;
  
  //how far apart the dots are placed apart from each other and from the edges of the die
  int dotSpace = dieThick/4;
  
  //one row for each face
  //1 means no dot 0 means yes dot
  int[][] faces = 
    {
    {1, 1, 1, 1, 0, 1, 1, 1, 1}, 
    {0, 1, 1, 1, 1, 1, 1, 1, 0}, 
    {0, 1, 1, 1, 0, 1, 1, 1, 0}, 
    {0, 1, 0, 1, 1, 1, 0, 1, 0}, 
    {0, 1, 0, 1, 0, 1, 0, 1, 0}, 
    {0, 1, 0, 0, 1, 0, 0, 1, 0}, 
  };

  Die(int x, int y) //constructor
  {
    myX = x;
    myY = y;
  }

  void roll()
  {
    diceNumber = (int)(Math.random()*6) + 1;
    sum += diceNumber;
  }
  
  void show()
  {
    //draw die
    fill(255, 255, 255);
    rect(myX, myY, dieThick, dieThick, 50);

    //draw dots
    for ( int i = 0; i < 9; i++)
    {
      //if the value for the dot in the face array is zero then it makes the dot black otherwise if the value is 1 the dot is white
      stroke(faces[diceNumber-1][i] * 255);
      fill(faces[diceNumber-1][i] * 255);
      
      //dot
      ellipse(myX + dotSpace + (dotSpace * (i%3)), myY + dotSpace + dotSpace * (i/3) + (i%3) * -8, 25, 25);
    }
  }
}
