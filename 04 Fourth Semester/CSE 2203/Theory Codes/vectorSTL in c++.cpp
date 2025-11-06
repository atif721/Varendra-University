#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

int main() {
    // Section: Inserting elements
    {
        vector<char> v = {'a', 'f', 'd'};
        // Inserting 'z' at the back
        v.push_back('z');
        // Inserting 'c' at index 1
        v.insert(v.begin() + 1, 'c');
        cout << "Inserting elements output: ";
        for (int i = 0; i < v.size(); i++)
            cout << v[i] << " ";
        cout << endl;
    }

    // Section: Finding vector size
    {
        vector<char> v = {'a', 'c', 'f', 'd', 'z'};
        // Finding size
        cout << "Finding vector size output: " << v.size() << endl;
    }

    // Section: Updating elements
    {
        vector<char> v = {'a', 'c', 'f', 'd', 'z'};
        // Accessing and printing values
        cout << "Updating elements initial access: " << v[3] << " " << v.at(2) << endl;
        // Updating values using indexes 3 and 2
        v[3] = 'D';
        v.at(2) = 'F';
        cout << "Updating elements after update: " << v[3] << " " << v.at(2) << endl;
    }

    // Section: Traversing
    {
        vector<char> v = {'a', 'c', 'f', 'd', 'z'};
        // Traversing vector using for loop
        cout << "Traversing output: ";
        for (int i = 0; i < v.size(); i++)
            cout << v[i] << " ";
        cout << endl;
    }

    // Section: Delete elements
    {
        vector<char> v = {'a', 'c', 'f', 'd', 'z'};
        // Deleting last element 'z'
        v.pop_back();
        // Deleting element 'f'
        v.erase(find(v.begin(), v.end(), 'f'));
        cout << "Delete elements output: ";
        for (int i = 0; i < v.size(); i++) {
            cout << v[i] << " ";
        }
        cout << endl;
    }

    // Section: C++ STL Sorting Algorithm (ascending)
    {
        // initialize vector of int type
        vector<int> v = {3, 2, 5, 1, 4};
        // sort vector elements in ascending order
        sort(v.begin(), v.end());
        // print the sorted vector
        cout << "Sorting ascending output: ";
        for (int i = 0; i < v.size(); i++) {
            cout << v[i] << " ";
        }
        cout << endl;
    }

    // Section: C++ STL Sorting Algorithm (descending)
    {
        // initialize vector of int type
        vector<int> v = {3, 2, 5, 1, 4};
        // sort vector elements in descending order
        sort(v.begin(), v.end(), greater<int>());
        // print the sorted vector
        cout << "Sorting descending output: ";
        for (int i = 0; i < v.size(); i++) {
            cout << v[i] << " ";
        }
        cout << endl;
    }

    // Section: Inserting in 2D vector
    {
        vector<vector<int>> v = {{1, 2, 3}, {4, 5, 6}};
        // Insert a new row at the end
        v.push_back({7, 8, 9});
        // Insert value in 2nd row at 2nd position
        v[1].insert(v[1].begin() + 1, 10);
        cout << "Inserting in 2D vector output:" << endl;
        for (int i = 0; i < v.size(); i++) {
            for (int j = 0; j < v[i].size(); j++) {
                cout << v[i][j] << " ";
            }
            cout << endl;
        }
    }

    return 0;
}
