#include <GL/glut.h>
#include <bits/stdc++.h>
using namespace std;


void display() {
    glClear(GL_COLOR_BUFFER_BIT);

    // Find centroid
    float cx = (x1_ + x2_ + x3_) / 3.0;
    float cy = (y1_ + y2_ + y3_) / 3.0;

    // Shift to center (300,300)
    int dx = 300 - cx;
    int dy = 300 - cy;

    glColor3f(1.0, 0.0, 0.8);
    glLineWidth(2.0);

    glBegin(GL_LINES);
    glVertex2i(x1_ + dx, y1_ + dy);
    glVertex2i(x2_ + dx, y2_ + dy);

    glVertex2i(x2_ + dx, y2_ + dy);
    glVertex2i(x3_ + dx, y3_ + dy);

    glVertex2i(x3_ + dx, y3_ + dy);
    glVertex2i(x1_ + dx, y1_ + dy);
    glEnd();

    glFlush();
}

int main(int argc, char** argv) {

    // User input
    cout << "Enter x1 y1: ";
    cin >> x1_ >> y1_;

    cout << "Enter x2 y2: ";
    cin >> x2_ >> y2_;

    cout << "Enter x3 y3: ";
    cin >> x3_ >> y3_;

    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);
    glutInitWindowSize(600, 600);
    glutCreateWindow("Centered Triangle");

    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluOrtho2D(0.0, 600.0, 0.0, 600.0);

    glutDisplayFunc(display);
    glutMainLoop();

    return 0;
}