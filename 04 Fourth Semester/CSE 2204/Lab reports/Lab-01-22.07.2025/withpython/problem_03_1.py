#include <iostream>
using namespace std;

int inputDimension(string value) {
    int val;
    cout << value;
    cin >> val;

    return val;
}

int** inputMatrix(int m, int n) {
    int** matrix = new int* [m];
    for (int i = 0; i < m; i++) {
        matrix[i] = new int[n];
    }

    for (int i = 0; i < m; i++)
    {

        for (int j = 0; j < n; j++)
        {
            cout << "Enter (row-" << i + 1 << ",column-" << j + 1 << ") : ";
            cin >> matrix[i][j];
        }
    }

    return matrix;
}

void printMatrix(int** matrix, int m, int n) {
    cout << endl
        << "------ " << m << "*" << n << " Matrix -----" << endl
        << endl;

    for (int i = 0; i < m; i++)
    {
        for (int j = 0; j < n; j++)
        {
            cout << matrix[i][j] << " ";
        }
        cout << endl;
    }

    for (int i = 0; i < m; i++) {
        delete [] matrix[i];
    }
    delete [] matrix;
}

int main() {

    int m = inputDimension("Enter the row of the matrix : ");
    int n = inputDimension("Enter the column of the matrix : ");


    int** matrix = inputMatrix(m, n);
    printMatrix(matrix, m, n);

    return 0;
}