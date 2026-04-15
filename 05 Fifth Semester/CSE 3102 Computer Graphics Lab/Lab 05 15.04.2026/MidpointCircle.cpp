#include <GL/glut.h>

int xc = 0, yc = 0, r = 100;

// Draw 8 symmetric points
void drawCirclePoints(int x, int y)
{
    glVertex2i(xc + x, yc + y);
    glVertex2i(xc - x, yc + y);
    glVertex2i(xc + x, yc - y);
    glVertex2i(xc - x, yc - y);
    glVertex2i(xc + y, yc + x);
    glVertex2i(xc - y, yc + x);
    glVertex2i(xc + y, yc - x);
    glVertex2i(xc - y, yc - x);
}

void display() {
    glClear(GL_COLOR_BUFFER_BIT);

    glColor3f(0.0, 0.0, 0.0); // black color
    glPointSize(2.0);

    glBegin(GL_POINTS);

    int x = 0;
    int y = r;

    int p = 1 - r; // initial decision parameter

    while (x <= y)
    {
        drawCirclePoints(x, y);

        x++;

        if (p < 0)
        {
            p = p + 2 * x + 1;
        }
        else
        {
            y--;
            p = p + 2 * x - 2 * y + 1;
        }
    }

    glEnd();
    glFlush();
}

void init() {
    glClearColor(1.0, 1.0, 1.0, 1.0); // white background
    gluOrtho2D(-250, 250, -250, 250); // coordinate system
}

int main(int argc, char **argv) {
    // You can change values here
    xc = 0;
    yc = 0;
    r = 100;

    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);
    glutInitWindowSize(500, 500);
    glutInitWindowPosition(100, 100);
    glutCreateWindow("Midpoint Circle using OpenGL");

    init();
    glutDisplayFunc(display);
    glutMainLoop();

    return 0;
}