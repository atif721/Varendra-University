#include <bits/stdc++.h>
using namespace std;

// this for loop is called foreach loop
void printVector(vector<int> vect) {
  cout << "Vector elements : ";
  for (int x : vect) {
    cout << x << " ";
  }
  cout << endl;
}

void print2DMatrix(vector<vector<int>> matrix) {
  for (auto row : matrix) {
    for (int val : row) {
      cout << val << " ";
    }
    cout << endl;
  }
}

int main() {

  // declared a vector
  vector<int> vector1;

  // by using push_back() we can insert element at end
  vector1.push_back(40);
  vector1.push_back(20);
  vector1.push_back(45);
  vector1.push_back(25);
  vector1.push_back(35);
  vector1.push_back(50);
  vector1.push_back(30);

  // printing vector
  printVector(vector1);


  // by using insert we can insert element at a certain index
  vector1.insert(vector1.begin(), 10);
  cout << "After inserting 10, ";
  printVector(vector1);


  // using index we can update the value
  vector1[0] = 15;
  cout << "After replacing 10, ";
  printVector(vector1);


  // pop_back removes element from last
  vector1.pop_back();
  cout << "After removing last element, ";
  printVector(vector1);


  // erase () removes element at index
  vector1.erase(vector1.begin() + 1);
  cout << "After removing element at index_1, ";
  printVector(vector1);


  // size() calculates the size of the vector
  cout << "Vector's current size : " << vector1.size() << endl;


  // asscending order sort
  cout << "After asscending order sort, ";
  sort(vector1.begin(), vector1.end());
  printVector(vector1);


  // descending order sort
  cout << "After descending order sort, ";
  sort(vector1.begin(), vector1.end(), greater<int>());
  printVector(vector1);
  cout << endl << endl;


  // create 2D matrix using vector
  cout << "-----2D Matrix-----" << endl << endl;
  vector<vector<int>> matrix;

  matrix.push_back({1,2,3});
  matrix.push_back({4,5,6});
  matrix.push_back({7,8,9});


  cout << "2D matrix elements are : " << endl;
  print2DMatrix(matrix);


  // clearing the vector
  vector1.clear();
  matrix.clear();


  cout << endl;
  return 0;
}