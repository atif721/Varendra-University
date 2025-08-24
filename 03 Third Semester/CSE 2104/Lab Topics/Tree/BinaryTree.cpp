#include <iostream>
using namespace std;

class Node {
public:
    int data;
    Node* left;
    Node* right;

    Node(int val) {
        data = val;
        left = nullptr;
        right = nullptr;
    }
};

class BinaryTree {
public:
    Node* root;

    BinaryTree() {
        root = nullptr;
    }

    void preorder(Node* node) {
        if (node == nullptr) return;
        cout << node->data << " ";
        preorder(node->left);
        preorder(node->right);
    }

    void inorder(Node* node) {
        if (node == nullptr) return;
        inorder(node->left);
        cout << node->data << " ";
        inorder(node->right);
    }

    void postorder(Node* node) {
        if (node == nullptr) return;
        postorder(node->left);
        postorder(node->right);
        cout << node->data << " ";
    }

    void showAllTraversals() {
        cout << "\nPreorder: ";
        preorder(root);
        cout << "\nInorder: ";
        inorder(root);
        cout << "\nPostorder: ";
        postorder(root);
        cout << endl;
    }
};

int main() {
    BinaryTree tree;

    // Creating this structure manually:
    //       1
    //      / \
    //     2   3
    //    / \
    //   4   5

    tree.root = new Node(1);
    tree.root->left = new Node(2);
    tree.root->right = new Node(3);
    tree.root->left->left = new Node(4);
    tree.root->left->right = new Node(5);

    cout << "Binary Tree Traversals:";
    tree.showAllTraversals();

    return 0;
}
