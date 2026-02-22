#include <GL/glut.h>

void display() {
  glClear(GL_COLOR_BUFFER_BIT);

  glBegin(GL_TRIANGLES);
  glVertex2f(-0.5, -0.5);

  glColor3f(0.0, 1.0, 0.0);
  glVertex2f(0.5, -0.5);

  glColor3f(0.0, 0.0, 1.0);
  glVertex2f(0.0, 0.5);
  glEnd();

  glFlush();
}

void init() {
  glClearColor(1.0, 1.0, 1.0, 1.0);
}

int main(int argc, char **argv) {
  glutInit(&argc, argv);
  glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);
  glutInitWindowSize(500, 500);
  glutInitWindowPosition(100, 100);
  glutCreateWindow("Triangle using OpenGL");

  init();
  glutDisplayFunc(display);
  glutMainLoop();

  return 0;
}
