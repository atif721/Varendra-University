#include <GL/glut.h>
#include <bits/stdc++.h>

using namespace std;

// ─── Global State ────────────────────────────────────────────────────────────
float trainX = -500.0f;   // train horizontal position
float wheelAngle = 0.0f;      // wheel rotation angle (degrees)
float smokeOffset = 0.0f;      // smoke rising offset

struct SmokeParticle {
  float x, y, alpha, size, speed;
};

vector<SmokeParticle> smoke;

// ─── Utilities ────────────────────────────────────────────────────────────────
void drawCircle(float cx, float cy, float r, int segs = 64) {
  glBegin(GL_TRIANGLE_FAN);
  glVertex2f(cx, cy);
  for (int i = 0; i <= segs; ++i) {
    float a = 2.0f * M_PI * i / segs;
    glVertex2f(cx + r * cos(a), cy + r * sin(a));
  }
  glEnd();
}

void drawCircleOutline(float cx, float cy, float r, int segs = 64) {
  glBegin(GL_LINE_LOOP);
  for (int i = 0; i < segs; ++i) {
    float a = 2.0f * M_PI * i / segs;
    glVertex2f(cx + r * cos(a), cy + r * sin(a));
  }
  glEnd();
}

void drawRect(float x, float y, float w, float h) {
  glBegin(GL_QUADS);
  glVertex2f(x, y);
  glVertex2f(x + w, y);
  glVertex2f(x + w, y + h);
  glVertex2f(x, y + h);
  glEnd();
}

// ─── Scene Components ─────────────────────────────────────────────────────────

// Sky gradient (top of scene)
void drawSky() {
  glBegin(GL_QUADS);
  glColor3f(0.53f, 0.81f, 0.98f); glVertex2f(0, 600);
  glColor3f(0.53f, 0.81f, 0.98f); glVertex2f(800, 600);
  glColor3f(0.87f, 0.95f, 1.00f); glVertex2f(800, 200);
  glColor3f(0.87f, 0.95f, 1.00f); glVertex2f(0, 200);
  glEnd();
}

// Ground
void drawGround() {
  glColor3f(0.42f, 0.56f, 0.26f);
  drawRect(0, 0, 800, 215);
  // grass top strip
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
    glVertex2f(700 + 55 * cos(a), 530 + 55 * sin(a));
    glVertex2f(700 + 75 * cos(a), 530 + 75 * sin(a));
  }
  glEnd();
}

// Clouds
void drawCloud(float cx, float cy) {
  glColor3f(1, 1, 1);
  drawCircle(cx, cy, 28);
  drawCircle(cx + 30, cy + 8, 22);
  drawCircle(cx - 28, cy + 5, 20);
  drawCircle(cx + 10, cy + 18, 18);
}

// Trees
void drawTree(float x, float y) {
  // trunk
  glColor3f(0.40f, 0.25f, 0.10f);
  drawRect(x - 6, y, 12, 40);
  // foliage layers
  glColor3f(0.13f, 0.55f, 0.13f);
  glBegin(GL_TRIANGLES);
  glVertex2f(x, y + 100); glVertex2f(x - 38, y + 40); glVertex2f(x + 38, y + 40);
  glVertex2f(x, y + 125); glVertex2f(x - 28, y + 68); glVertex2f(x + 28, y + 68);
  glVertex2f(x, y + 148); glVertex2f(x - 18, y + 95); glVertex2f(x + 18, y + 95);
  glEnd();
}

// Railway tracks (rails + sleepers)
void drawTracks() {
  // sleepers
  glColor3f(0.35f, 0.22f, 0.08f);
  for (int x = 0; x <= 800; x += 40) {
    drawRect(x, 192, 26, 10);
  }
  // rails
  glColor3f(0.60f, 0.60f, 0.65f);
  drawRect(0, 200, 800, 6);   // top rail
  drawRect(0, 187, 800, 6);   // bottom rail

  // rail shine
  glColor3f(0.85f, 0.85f, 0.90f);
  drawRect(0, 203, 800, 2);
  drawRect(0, 190, 800, 2);
}

// ─── Wheel ────────────────────────────────────────────────────────────────────
void drawWheel(float cx, float cy, float r) {
  // outer tyre
  glColor3f(0.15f, 0.15f, 0.15f);
  drawCircle(cx, cy, r);

  // inner hub
  glColor3f(0.80f, 0.30f, 0.10f);
  drawCircle(cx, cy, r * 0.55f);

  // spokes (rotated with wheelAngle)
  glColor3f(0.90f, 0.50f, 0.20f);
  glLineWidth(2.5f);
  glPushMatrix();
  glTranslatef(cx, cy, 0);
  glRotatef(wheelAngle, 0, 0, 1);
  glBegin(GL_LINES);
  for (int i = 0; i < 6; ++i) {
    float a = 2.0f * M_PI * i / 6;
    glVertex2f(0, 0);
    glVertex2f((r - 2) * cos(a), (r - 2) * sin(a));
  }
  glEnd();
  glPopMatrix();

  // centre bolt
  glColor3f(0.20f, 0.20f, 0.20f);
  drawCircle(cx, cy, r * 0.12f);

  // tyre outline
  glColor3f(0.30f, 0.30f, 0.30f);
  glLineWidth(1.5f);
  drawCircleOutline(cx, cy, r);
}

// ─── Train ────────────────────────────────────────────────────────────────────
void drawTrain(float tx) {
  // ── Tender (coal car behind engine) ────────────────
  float tenderX = tx - 155;

  // tender body
  glColor3f(0.20f, 0.20f, 0.22f);
  drawRect(tenderX, 215, 130, 55);
  // tender top rim
  glColor3f(0.15f, 0.15f, 0.17f);
  drawRect(tenderX + 5, 260, 120, 12);
  // coal (lumpy top)
  glColor3f(0.12f, 0.12f, 0.12f);
  drawRect(tenderX + 10, 265, 110, 8);

  // tender wheels
  drawWheel(tenderX + 25, 205, 18);
  drawWheel(tenderX + 75, 205, 18);
  drawWheel(tenderX + 115, 205, 18);

  // coupler between tender and engine
  glColor3f(0.50f, 0.50f, 0.50f);
  drawRect(tx - 25, 220, 28, 8);

  // ── Engine body ────────────────────────────────────
  // boiler (long cylinder – drawn as rounded rect)
  glColor3f(0.85f, 0.20f, 0.12f);
  drawRect(tx, 220, 170, 60);

  // boiler dome
  glColor3f(0.80f, 0.18f, 0.10f);
  drawCircle(tx + 50, 283, 18);

  // cab (driver cabin)
  glColor3f(0.25f, 0.22f, 0.20f);
  drawRect(tx + 115, 230, 60, 70);

  // cab roof
  glColor3f(0.18f, 0.15f, 0.13f);
  drawRect(tx + 110, 298, 70, 10);

  // cab windows
  glColor3f(0.55f, 0.85f, 0.95f);
  drawRect(tx + 122, 258, 20, 22);
  drawRect(tx + 150, 258, 20, 22);

  // window frames
  glColor3f(0.60f, 0.60f, 0.60f);
  glLineWidth(1.5f);
  glBegin(GL_LINE_LOOP);
  glVertex2f(tx + 122, 258); glVertex2f(tx + 142, 258);
  glVertex2f(tx + 142, 280); glVertex2f(tx + 122, 280);
  glEnd();
  glBegin(GL_LINE_LOOP);
  glVertex2f(tx + 150, 258); glVertex2f(tx + 170, 258);
  glVertex2f(tx + 170, 280); glVertex2f(tx + 150, 280);
  glEnd();

  // front plate (smoke-box door)
  glColor3f(0.20f, 0.18f, 0.16f);
  drawRect(tx - 2, 222, 24, 55);
  drawCircle(tx + 10, 250, 14);
  glColor3f(0.50f, 0.50f, 0.50f);
  drawCircle(tx + 10, 250, 6);

  // boiler bands
  glColor3f(0.70f, 0.15f, 0.08f);
  for (int i = 0; i < 3; ++i)
    drawRect(tx + 30 + i * 28, 220, 5, 60);

  // running plate (lower sill)
  glColor3f(0.30f, 0.30f, 0.30f);
  drawRect(tx - 5, 217, 185, 8);

  // cowcatcher / pilot
  glColor3f(0.50f, 0.50f, 0.55f);
  glBegin(GL_TRIANGLES);
  glVertex2f(tx, 217);
  glVertex2f(tx - 30, 207);
  glVertex2f(tx, 207);
  glEnd();
  glBegin(GL_QUADS);
  glVertex2f(tx - 30, 207); glVertex2f(tx, 207);
  glVertex2f(tx, 210); glVertex2f(tx - 28, 210);
  glEnd();

  // headlight
  glColor3f(1.0f, 0.95f, 0.60f);
  drawCircle(tx + 2, 265, 7);
  glColor3f(1.0f, 1.0f, 0.80f);
  drawCircle(tx + 2, 265, 3.5f);

  // smokestack
  glColor3f(0.18f, 0.15f, 0.13f);
  drawRect(tx + 15, 280, 22, 35);   // stack body
  drawRect(tx + 10, 312, 32, 8);    // stack cap flare

  // ── Engine Wheels ──────────────────────────────────
  // large driving wheels
  drawWheel(tx + 30, 205, 22);
  drawWheel(tx + 80, 205, 22);
  drawWheel(tx + 130, 205, 22);
  // small leading wheels
  drawWheel(tx - 10, 207, 14);
  // small trailing wheel
  drawWheel(tx + 162, 207, 14);

  // connecting rod
  glColor3f(0.70f, 0.70f, 0.72f);
  glLineWidth(4.0f);
  glBegin(GL_LINE_STRIP);
  glVertex2f(tx + 30, 205);
  glVertex2f(tx + 80, 205);
  glVertex2f(tx + 130, 205);
  glEnd();

  // piston / valve gear
  glColor3f(0.60f, 0.60f, 0.62f);
  drawRect(tx + 5, 212, 30, 5);
  glLineWidth(2.0f);
  glBegin(GL_LINES);
  glVertex2f(tx + 35, 214); glVertex2f(tx + 30, 205);
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
    // filled circle approximation for smoke puff
    int segs = 20;
    glBegin(GL_TRIANGLE_FAN);
    glVertex2f(p.x, p.y);
    for (int i = 0; i <= segs; ++i) {
      float a = 2.0f * M_PI * i / segs;
      glVertex2f(p.x + p.size * cos(a), p.y + p.size * sin(a));
    }
    glEnd();
  }
}

void updateSmoke(float stackX, float stackY) {
  for (auto &p : smoke) {
    p.y += p.speed * 1.2f;
    p.x += (rand() % 3 - 1) * 0.3f;
    p.size += 0.25f;
    p.alpha -= 0.008f;
  }
  // remove dead particles
  smoke.erase(
    remove_if(smoke.begin(), smoke.end(), [](const SmokeParticle &p) { return p.alpha <= 0; }),
    smoke.end()
  );
  // spawn new
  spawnSmoke(stackX, stackY);
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

  // background trees
  drawTree(60, 155);
  drawTree(200, 145);
  drawTree(500, 150);
  drawTree(680, 148);
  drawTree(760, 155);

  drawTracks();

  // enable blending for smoke alpha
  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  drawSmoke();
  glDisable(GL_BLEND);

  drawTrain(trainX);

  glutSwapBuffers();
}

// ─── Timer / Animation ────────────────────────────────────────────────────────
void timer(int) {
  // move train
  trainX += 1.5f;
  if (trainX > 900.0f) trainX = -320.0f;   // wrap around

  // rotate wheels (larger wheel → slower spin)
  wheelAngle -= 3.5f;
  if (wheelAngle < -360.0f) wheelAngle += 360.0f;

  // update smoke (stack is at trainX + 26, top ~315)
  updateSmoke(trainX + 26, 318);

  glutPostRedisplay();
  glutTimerFunc(16, timer, 0);   // ~60 fps
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

  // set 2D ortho projection
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
  gluOrtho2D(0, 800, 0, 600);
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();

  glutDisplayFunc(display);
  glutTimerFunc(16, timer, 0);
  glutMainLoop();
  return 0;
}