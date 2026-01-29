#include <bits/stdc++.h>
using namespace std;

struct Activity {
  char name;
  int start, finish;
};

int main() {
  vector<Activity> acts = {
      {'A', 1, 4},
      {'B', 3, 5},
      {'C', 0, 6},
      {'D', 5, 7}, // change to 8 to test modified D
      {'E', 8, 9},
      {'F', 5, 9},
      {'G', 6, 10}
  };

  sort(acts.begin(), acts.end(), [](const Activity &a, const Activity &b) {
    return a.finish < b.finish;
    });

  cout << "Selected activities:\n";
  int lastFinish = -1;
  for (auto &a : acts) {
    if (a.start >= lastFinish) {
      cout << a.name << " (start: " << a.start << ", finish: " << a.finish << ")\n";
      lastFinish = a.finish;
    }
  }

  return 0;
}

/*
#include <bits/stdc++.h>
using namespace std;

struct Activity {
    int id;
    int start, finish;
};

int main() {
    int n;
    cout << "Enter number of activities: ";
    cin >> n;

    vector<Activity> acts(n);
    cout << "Enter start and finish times for each activity:\n";
    for (int i = 0; i < n; ++i) {
        cout << "Activity " << i + 1 << " (start finish): ";
        cin >> acts[i].start >> acts[i].finish;
        acts[i].id = i + 1;
    }

    sort(acts.begin(), acts.end(), [](const Activity &a, const Activity &b) {
        return a.finish < b.finish;
    });

    vector<Activity> selected;
    int lastFinish = -1;

    for (auto &a : acts) {
        if (a.start >= lastFinish) {
            selected.push_back(a);
            lastFinish = a.finish;
        }
    }

    cout << "\nMaximum number of non-overlapping activities: "
         << selected.size() << "\n";
    cout << "Selected activities (id, start, finish):\n";
    for (auto &a : selected) {
        cout << "Activity " << a.id << ": "
             << a.start << " " << a.finish << "\n";
    }

    return 0;
}
*/