#include <GL/glut.h>
float r = 1.0, g = 0.0, b = 0.0;

void display() {
  glClear(GL_COLOR_BUFFER_BIT);
  glColor3f(r, g, b);
  glRectf(-0.8, -0.8, 0.8, 0.8);  // Preview square
  glutSwapBuffers();
}

// glLineWidth(4.0);
// glBegin(GL_LINES);
// glVertex2f(xs, ys);
// glVertex2f(xe, ye);

void mouse(int btn, int state, int x, int y) {
  if (btn == GLUT_LEFT_BUTTON && state == GLUT_DOWN) {
    // Example: Map x to red (0-1), y inverted for screen coords
    r = (float)x / glutGet(GLUT_WINDOW_WIDTH);
    g = 1.0 - (float)y / glutGet(GLUT_WINDOW_HEIGHT);
    b = 0.5;  // Fixed or add slider
    glutPostRedisplay();
  }
}

int main(int argc, char **argv) {
  glutInit(&argc, argv);
  glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB);
  glutInitWindowSize(800, 600);
  glutCreateWindow("GLUT Color Picker");
  glutDisplayFunc(display);
  glutMouseFunc(mouse);
  glutMainLoop();
  return 0;
}
