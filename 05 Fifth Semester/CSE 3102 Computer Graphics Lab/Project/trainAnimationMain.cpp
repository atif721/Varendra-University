#include <GL/glut.h>
#include <bits/stdc++.h>

using namespace std;

// ─── Global State ────────────────────────────────────────────────────────────
float trainX = -500.0f;        // train horizontal position
float wheelAngle = 0.0f;       // wheel rotation angle (degrees)
float trainSpeed = 1.5f;       // train movement speed

struct SmokeParticle {
  float x, y, alpha, size, speed;
};

vector<SmokeParticle> smoke;

// ─── Utilities (Only using GL_LINES and glVertex2i) ──────────────────────────

// Solid filled circle using horizontal line scanning
void drawCircle(int cx, int cy, int r) {
  glBegin(GL_LINES);
  for (int dy = -r; dy <= r; ++dy) {
    int dx = round(sqrt(r * r - dy * dy));
    glVertex2i(cx - dx, cy + dy);
    glVertex2i(cx + dx, cy + dy);
  }
  glEnd();
}

// Hollow circle outline using GL_LINES segments
void drawCircleOutline(int cx, int cy, int r, int segs = 64) {
  glBegin(GL_LINES);
  int prevX = cx + r;
  int prevY = cy;
  for (int i = 1; i <= segs; ++i) {
    float a = 2.0f * M_PI * i / segs;
    int x = cx + round(r * cos(a));
    int y = cy + round(r * sin(a));
    glVertex2i(prevX, prevY);
    glVertex2i(x, y);
    prevX = x; prevY = y;
  }
  glEnd();
}

// Solid filled rectangle using horizontal line scanning
void drawRect(int x, int y, int w, int h) {
  glBegin(GL_LINES);
  for (int i = 0; i < h; ++i) {
    glVertex2i(x, y + i);
    glVertex2i(x + w, y + i);
  }
  glEnd();
}

// ─── Scene Components ─────────────────────────────────────────────────────────

// Sky gradient filled with horizontal GL_LINES
void drawSky() {
  glBegin(GL_LINES);
  for (int y = 200; y <= 600; ++y) {
    float t = (float)(y - 200) / 400.0f;
    // Interpolate from bottom color to top color
    float r = 0.87f + t * (0.53f - 0.87f);
    float g = 0.95f + t * (0.81f - 0.95f);
    float b = 1.00f + t * (0.98f - 1.00f);
    glColor3f(r, g, b);
    glVertex2i(0, y);
    glVertex2i(800, y);
  }
  glEnd();
}

// Ground
void drawGround() {
  glColor3f(0.42f, 0.56f, 0.26f);
  drawRect(0, 0, 800, 215);
  // Grass top strip
  glColor3f(0.48f, 0.65f, 0.30f);
  drawRect(0, 210, 800, 12);
}

// Sun
void drawSun() {
  glColor3f(1.0f, 0.92f, 0.23f);
  drawCircle(700, 530, 50);
  // rays
  glColor3f(1.0f, 0.85f, 0.10f);
  glLineWidth(2.5f);
  glBegin(GL_LINES);
  for (int i = 0; i < 12; ++i) {
    float a = 2.0f * M_PI * i / 12;
    glVertex2i(700 + round(55 * cos(a)), 530 + round(55 * sin(a)));
    glVertex2i(700 + round(75 * cos(a)), 530 + round(75 * sin(a)));
  }
  glEnd();
}

// Clouds
void drawCloud(int cx, int cy) {
  glColor3f(1, 1, 1);
  drawCircle(cx, cy, 28);
  drawCircle(cx + 30, cy + 8, 22);
  drawCircle(cx - 28, cy + 5, 20);
  drawCircle(cx + 10, cy + 18, 18);
}

// Railway tracks
void drawTracks() {
  // Sleepers
  glColor3f(0.35f, 0.22f, 0.08f);
  for (int x = 0; x <= 800; x += 40) {
    drawRect(x, 192, 26, 10);
  }
  // Rails
  glColor3f(0.60f, 0.60f, 0.65f);
  drawRect(0, 200, 800, 6);
  drawRect(0, 187, 800, 6);

  // Rail shine
  glColor3f(0.85f, 0.85f, 0.90f);
  drawRect(0, 203, 800, 2);
  drawRect(0, 190, 800, 2);
}

// ─── Wheel ────────────────────────────────────────────────────────────────────
void drawWheel(int cx, int cy, int r) {
  // Outer tyre
  glColor3f(0.15f, 0.15f, 0.15f);
  drawCircle(cx, cy, r);

  // Inner hub
  glColor3f(0.80f, 0.30f, 0.10f);
  drawCircle(cx, cy, round(r * 0.55f));

  // Spokes
  glColor3f(0.90f, 0.50f, 0.20f);
  glLineWidth(2.5f);
  glPushMatrix();
  glTranslatef(cx, cy, 0);
  glRotatef(wheelAngle, 0, 0, 1);
  glBegin(GL_LINES);
  for (int i = 0; i < 6; ++i) {
    float a = 2.0f * M_PI * i / 6;
    glVertex2i(0, 0);
    glVertex2i(round((r - 2) * cos(a)), round((r - 2) * sin(a)));
  }
  glEnd();
  glPopMatrix();

  // Centre bolt
  glColor3f(0.20f, 0.20f, 0.20f);
  drawCircle(cx, cy, round(r * 0.12f));

  // Tyre outline
  glColor3f(0.30f, 0.30f, 0.30f);
  glLineWidth(1.5f);
  drawCircleOutline(cx, cy, r);
}

// ─── Train ────────────────────────────────────────────────────────────────────
void drawTrain(int tx) {
  int tenderX = tx - 155;

  // Tender body
  glColor3f(0.20f, 0.20f, 0.22f);
  drawRect(tenderX, 215, 130, 55);
  // Tender top rim
  glColor3f(0.15f, 0.15f, 0.17f);
  drawRect(tenderX + 5, 260, 120, 12);
  // Coal
  glColor3f(0.12f, 0.12f, 0.12f);
  drawRect(tenderX + 10, 265, 110, 8);

  // Tender wheels
  drawWheel(tenderX + 25, 205, 18);
  drawWheel(tenderX + 75, 205, 18);
  drawWheel(tenderX + 115, 205, 18);

  // Coupler between tender and engine
  glColor3f(0.50f, 0.50f, 0.50f);
  drawRect(tx - 25, 220, 28, 8);

  // Engine boiler
  glColor3f(0.85f, 0.20f, 0.12f);
  drawRect(tx, 220, 170, 60);

  // Boiler dome
  glColor3f(0.80f, 0.18f, 0.10f);
  drawCircle(tx + 50, 283, 18);

  // Cab
  glColor3f(0.25f, 0.22f, 0.20f);
  drawRect(tx + 115, 230, 60, 70);

  // Cab roof
  glColor3f(0.18f, 0.15f, 0.13f);
  drawRect(tx + 110, 298, 70, 10);

  // Cab windows
  glColor3f(0.55f, 0.85f, 0.95f);
  drawRect(tx + 122, 258, 20, 22);
  drawRect(tx + 150, 258, 20, 22);

  // Window frames (Using GL_LINES)
  glColor3f(0.60f, 0.60f, 0.60f);
  glLineWidth(1.5f);
  glBegin(GL_LINES);
  glVertex2i(tx + 122, 258); glVertex2i(tx + 142, 258);
  glVertex2i(tx + 142, 258); glVertex2i(tx + 142, 280);
  glVertex2i(tx + 142, 280); glVertex2i(tx + 122, 280);
  glVertex2i(tx + 122, 280); glVertex2i(tx + 122, 258);

  glVertex2i(tx + 150, 258); glVertex2i(tx + 170, 258);
  glVertex2i(tx + 170, 258); glVertex2i(tx + 170, 280);
  glVertex2i(tx + 170, 280); glVertex2i(tx + 150, 280);
  glVertex2i(tx + 150, 280); glVertex2i(tx + 150, 258);
  glEnd();

  // Front plate
  glColor3f(0.20f, 0.18f, 0.16f);
  drawRect(tx - 2, 222, 24, 55);
  drawCircle(tx + 10, 250, 14);
  glColor3f(0.50f, 0.50f, 0.50f);
  drawCircle(tx + 10, 250, 6);

  // Boiler bands
  glColor3f(0.70f, 0.15f, 0.08f);
  for (int i = 0; i < 3; ++i)
    drawRect(tx + 30 + i * 28, 220, 5, 60);

  // Running plate
  glColor3f(0.30f, 0.30f, 0.30f);
  drawRect(tx - 5, 217, 185, 8);

  // Cowcatcher built with horizontal GL_LINES to form the triangles/quads
  glColor3f(0.50f, 0.50f, 0.55f);
  glBegin(GL_LINES);
  // Main wedge section
  for (int y = 207; y <= 217; ++y) {
    int dx = round(30.0f * (217 - y) / 10.0f);
    glVertex2i(tx - dx, y);
    glVertex2i(tx, y);
  }
  // Small lower tip guard
  for (int y = 207; y <= 210; ++y) {
    glVertex2i(tx - 30, y);
    glVertex2i(tx, y);
  }
  glEnd();

  // Headlight
  glColor3f(1.0f, 0.95f, 0.60f);
  drawCircle(tx + 2, 265, 7);
  glColor3f(1.0f, 1.0f, 0.80f);
  drawCircle(tx + 2, 265, 3);

  // Smokestack
  glColor3f(0.18f, 0.15f, 0.13f);
  drawRect(tx + 15, 280, 22, 35);
  drawRect(tx + 10, 312, 32, 8);

  // Engine Wheels
  drawWheel(tx + 30, 205, 22);
  drawWheel(tx + 80, 205, 22);
  drawWheel(tx + 130, 205, 22);
  // Small wheels
  drawWheel(tx - 10, 207, 14);
  drawWheel(tx + 162, 207, 14);

  // Connecting rod (GL_LINES replacing GL_LINE_STRIP)
  glColor3f(0.70f, 0.70f, 0.72f);
  glLineWidth(4.0f);
  glBegin(GL_LINES);
  glVertex2i(tx + 30, 205); glVertex2i(tx + 80, 205);
  glVertex2i(tx + 80, 205); glVertex2i(tx + 130, 205);
  glEnd();

  // Piston
  glColor3f(0.60f, 0.60f, 0.62f);
  drawRect(tx + 5, 212, 30, 5);
  glLineWidth(2.0f);
  glBegin(GL_LINES);
  glVertex2i(tx + 35, 214); glVertex2i(tx + 30, 205);
  glEnd();
}

// ─── Smoke ────────────────────────────────────────────────────────────────────
void spawnSmoke(float baseX, float baseY) {
  if (smoke.size() < 40) {
    SmokeParticle p;
    p.x = baseX + (rand() % 10 - 5);
    p.y = baseY;
    p.alpha = 0.75f + 0.25f * (rand() % 100) / 100.0f;
    p.size = 10.0f + rand() % 12;
    p.speed = 0.6f + 0.4f * (rand() % 100) / 100.0f;
    smoke.push_back(p);
  }
}

void drawSmoke() {
  for (auto &p : smoke) {
    glColor4f(0.55f, 0.55f, 0.55f, p.alpha);
    drawCircle(round(p.x), round(p.y), round(p.size));
  }
}

void updateSmoke(float stackX, float stackY) {
  for (auto &p : smoke) {
    p.y += p.speed * 1.2f;
    p.x += (rand() % 3 - 1) * 0.3f;
    p.size += 0.25f;
    p.alpha -= 0.008f;
  }
  smoke.erase(
    remove_if(smoke.begin(), smoke.end(), [](const SmokeParticle &p) { return p.alpha <= 0; }),
    smoke.end()
  );
  spawnSmoke(stackX, stackY);
}

// ─── Keyboard Control ─────────────────────────────────────────────────────────
void keyboard(unsigned char key, int x, int y) {
  if (key == 'u' || key == 'U') {
    trainSpeed += 0.5f;       // Increase speed
  } else if (key == 'd' || key == 'D') {
    trainSpeed -= 0.5f;       // Decrease speed
    if (trainSpeed < 0.0f) {
      trainSpeed = 0.0f;      // Prevent train from going backwards
    }
  }
}

// ─── Display ──────────────────────────────────────────────────────────────────
void display() {
  glClear(GL_COLOR_BUFFER_BIT);

  drawSky();
  drawSun();
  drawCloud(100, 480);
  drawCloud(320, 510);
  drawCloud(560, 490);

  drawGround();
  drawTracks();

  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  drawSmoke();
  glDisable(GL_BLEND);

  drawTrain((int)trainX);

  glutSwapBuffers();
}

// ─── Timer / Animation ────────────────────────────────────────────────────────
void timer(int) {
  // Move train based on current speed
  trainX += trainSpeed;
  if (trainX > 900.0f) trainX = -320.0f;

  // Rotate wheels proportionally to speed
  wheelAngle -= (trainSpeed * 2.33f);
  if (wheelAngle < -360.0f) wheelAngle += 360.0f;

  // Update smoke
  updateSmoke(trainX + 26, 318);

  glutPostRedisplay();
  glutTimerFunc(16, timer, 0);
}

// ─── Main ─────────────────────────────────────────────────────────────────────
int main(int argc, char **argv) {
  srand(time(nullptr));

  glutInit(&argc, argv);
  glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB);
  glutInitWindowSize(800, 600);
  glutInitWindowPosition(100, 100);
  glutCreateWindow("Train Movement Animation");

  glClearColor(0.53f, 0.81f, 0.98f, 1.0f);

  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
  gluOrtho2D(0, 800, 0, 600);
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();

  glutDisplayFunc(display);
  glutKeyboardFunc(keyboard); // Bind keyboard function
  glutTimerFunc(16, timer, 0);
  glutMainLoop();

  return 0;
}