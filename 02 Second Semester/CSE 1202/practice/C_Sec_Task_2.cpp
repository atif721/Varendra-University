#include<iostream>
using namespace std;

class Book {
private:
    string title, author, isbn;
public:
    Book(string t, string a, string i) : title(t), author(a), isbn(i) {}

    virtual void displayDetails() {
        cout << "BOOK Title : " << title;
        cout << ", Author : " << author;
        cout << ", ISBN : " << isbn << endl;
    }
};

class EBook : public Book {
private:
    string format;
    double fileSize;

public:
    EBook(string t, string a, string i, double fs, string fr) : fileSize(fs), format(fr), Book(t, a, i) {}
    void displayDetails() override {
        cout << endl;
        Book::displayDetails();
        cout << "FileSize :  " << fileSize;
        cout << ", Format :  " << format << endl;
    }
};

class AudioBook : public Book {
private:
    string duration;
    string narrator;

public:
    AudioBook(string t, string a, string i, string nr, string dur) : duration(dur), narrator(nr), Book(t, a, i) {}

    void displayDetails() override {
        cout << endl;
        Book::displayDetails();
        cout << "Duration :  " << duration;
        cout << ", Narrator :  " << narrator << endl;
    }
};

int main() {
    system("cls");

    Book* book[3];
    book[0] = new Book("A book on C++", "Bala Goswami", "978-92-95055");
    book[1] = new EBook("Python Guide", "Jane Doe", "67890", 3.2, "PDF");
    book[2] = new AudioBook("War and Peace", "Leo Tolstoy", "11223","David Attenborough", "12.5");

    for (int i = 0; i < 3; i++) {
        book[i]->displayDetails();
        cout << "--------------------" << endl;
        delete book[i];
    }

    return 0;
}