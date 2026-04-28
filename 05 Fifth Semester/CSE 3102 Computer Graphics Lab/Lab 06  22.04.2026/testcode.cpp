#include <GL/glut.h>
#include <iostream>

using namespace std;

void draw_line(int x1, int Y1, int x2, int y2) {
  int dx = abs(x2 - x1);
  int dy = abs(y2 - Y1);

  if (dx != 0)
    cout << "Slope is: " << (float)(y2 - Y1) / (x2 - x1) << endl;

  int sx = (x1 < x2) ? 1 : -1;
  int sy = (Y1 < y2) ? 1 : -1;

  int err = dx - dy;

  int x = x1;
  int y = Y1;

  glBegin(GL_POINTS);

  while (true) {
    glVertex2i(x, y);
    if (x == x2 && y == y2)
      break;

    int e2 = 2 * err;

    if (e2 > -dy) {
      err -= dy;
      x += sx;
    }

    if (e2 < dx) {
      err += dx;
      y += sy;
    }
  }
  glEnd();
}

void drawCirclePoints(int xc, int yc, int x, int y) {
  glVertex2i(xc + x, yc + y);
  glVertex2i(xc - x, yc + y);
  glVertex2i(xc + x, yc - y);
  glVertex2i(xc - x, yc - y);
  glVertex2i(xc + y, yc + x);
  glVertex2i(xc - y, yc + x);
  glVertex2i(xc + y, yc - x);
  glVertex2i(xc - y, yc - x);
}

void draw_cicle(int xc, int yc, int r) {
  int x = 0;
  int y = r;
  int p = 1 - r;

  glBegin(GL_POINTS);

  while (x <= y) {
    drawCirclePoints(xc, yc, x, y);

    x++;

    if (p < 0) {
      p += 2 * x + 1;
    } else {
      y--;
      p += 2 * (x - y) + 1;
    }
  }

  glEnd();

}

void display() {
  glClear(GL_COLOR_BUFFER_BIT);
  glColor3f(0.0, 0.0, 0.0);

  draw_line(100, 200, 500, 200);
  draw_line(500, 200, 300, 50);
  draw_line(300, 50, 100, 200);
  draw_cicle(300, 200 + 50, 50);

  glFlush();
}

int main(int argc, char **argv) {
  glutInit(&argc, argv);
  glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);
  glutInitWindowSize(600, 600);
  glutCreateWindow("GLUT Project");

  gluOrtho2D(0, 600, 0, 600);
  glClearColor(1.0, 1.0, 1.0, 1.0);


  glutDisplayFunc(display);
  glutMainLoop();

  return 0;
}
