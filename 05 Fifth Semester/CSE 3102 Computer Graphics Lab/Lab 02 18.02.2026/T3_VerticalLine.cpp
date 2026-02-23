#include <GL/glut.h>

void display() {
  glClearColor(0.94f, 0.94f, 0.94f, 1.0f);
  glBegin(GL_TRIANGLES);
  glVertex2f(-0.5, -0.5);

  glColor3f(0.0, 1.0, 0.0);
  glVertex2f(0.5, -0.5);

  glColor3f(0.0, 0.0, 1.0);
  glVertex2f(0.0, 0.5);
  glEnd();

  glFlush();
}


int main(int argc, char **argv) {
  glutInit(&argc, argv);
  glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);
  glutInitWindowSize(500, 500);
  glutInitWindowPosition(100, 100);
  glutCreateWindow("Triangle using OpenGL");

  glutDisplayFunc(display);
  glutMainLoop();

  return 0;
}
