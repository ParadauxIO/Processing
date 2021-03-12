private static final int ENEMY_COUNT = 3;
private static final int GAP_SIZE = 100;

private boolean stillAlive;
private int playerScore;

private Enemy[] enemies;
private Player player;

/** 

  I didn't stick to the brief, apologies. I'm not overly familiar with how to shoot bullets in processing, and I thought just recreating flappy bird would be much more completable in the time frame.
  It's pretty buggy, I haven't set a bounds as to where the gap can occur. Enemies are the pipes in my case, but they still have (somewhat iffy) collission detection. 
  
  I've written a flappybird before in Phaser.js, so I knew roughly what I was doing, games aren't really my thing.
  
  I wrote the code to be perfectly good java, as I'm not entirely aware of the processing conventions.
*/

public void setup() {
    player = new Player();
    enemies = new Enemy[3];
    stillAlive = false;
    playerScore = 0;
    
    size(800, 600);
    
    // Create the enemies (in our case the pipes, represented by lines as the collisions are easier.)
    for (int i = 0; i < ENEMY_COUNT; i++) {
        enemies[i] = new Enemy(i);
    }

}

public void draw() {
    background(204, 255, 255);
    
    if (stillAlive) {
        player.move();
    }
    
    player.draw();
    
    if (stillAlive) {
        player.doGravity();
    }
    
    player.handleCollisions();
    
    for (Enemy enemy : enemies) {
        enemy.draw();
        enemy.checkPosition();
    }
    
    fill(204, 255, 255);
    stroke(255);
    textSize(32);
    
    if (stillAlive) {
        stroke(0);
        rect(20, 20, 50, 50);
        fill(0);
        text(playerScore, 30, 58);
        return;
    } 
    
    stroke(0);
    rect(150, 100, 200, 50);
    rect(150, 200, 200, 50);

    fill(0);
    text("Game Over!", 160, 135);
    text("Score:", 180, 240);
    text(playerScore, 280, 240);
}

// Reset the screen
public void reset() {
    stillAlive = true;
    playerScore = 0;
    player.currentY = 400;
    
    for (Enemy enemy : enemies) {
        enemy.setX(enemy.getX() + 550);
        enemy.setAwardStatus(false);
    }
}

// Any mouse button
public void mousePressed() {
    player.jump();
    
    if (stillAlive == false) {
        reset();
    }
}

// Any key pressed
public void keyPressed() {
    player.jump();

    if (stillAlive == false) {
        reset();
    }
}

/** 
 * Represents the "bird" on the screen.
 * */
public class Player {
  
    private float currentX;
    private float currentY;
    private float velocity;
  
    Player() {
        currentX = 250;
        currentY = 400;
    }

    public void draw() {
        fill(255, 255, 0);
        ellipse(currentX, currentY, 25, 25);
    }

    // Counteract gravity by giving an artifical boost to velocity (like a bird flapping its wings)
    public void jump() {
        velocity = -10;
    }

    // Mimick gravity by having a downwards force on the player
    public void doGravity() {
        velocity += 0.4;
    }

    public void move() {
        currentY += velocity;
        
        // Move enemies
        for (Enemy enemy : enemies) {
            enemy.setX(enemy.getX() - 3);
        }
    }

    public void handleCollisions() {
        
      // If they fell out of the world.
      if (currentY > 800) {
          stillAlive = false;
      }
        
      // For every enemy on screen
      for (Enemy enemy : enemies) {
          if ((this.currentX < enemy.getX() + 10 && this.currentX > enemy.getX() - 10) && (this.currentY < enemy.getGap() - GAP_SIZE || this.currentY > enemy.getGap() + GAP_SIZE)) {
              stillAlive = false;
          }
      }
    }
}

/**
 * Represents the enemy, which is the pipes in our case.
 */
public class Enemy {
    private float currentX;
    private float currentGap;
    
    private boolean hasAwardedScore = false;

    public Enemy(int identifier) {
        currentX = 100 + (identifier * 200);
        currentGap = random(600) + GAP_SIZE;
    }

    // Put the enemy on the screen
    public void draw() {
        stroke(5, 242, 72);
        strokeWeight(4);
        line(currentX, 0, currentX, currentGap - GAP_SIZE);
        line(currentX, currentGap + GAP_SIZE, currentX, 800);     
        strokeWeight(1);
    }

    // Award points if the player has passed it.
    public void checkPosition() {
        if (currentX < 0) {
            currentX += (200 * 3);
            currentGap = random(600) + 100;
            hasAwardedScore = false;
        }
        
        if (currentX < 250 && !hasAwardedScore) {
            hasAwardedScore = true;
            playerScore++;
        }
    }
    
    public float getX() {
      return currentX;
    }
    
    public void setX(float x) {
      this.currentX = x;
    }
    
    public float getGap() {
      return currentGap;
    }
    
    public void setAwardStatus(boolean status) {
      this.hasAwardedScore = status;
    }

}
