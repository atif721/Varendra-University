#inclide<iostream>
using namespace std;
struct Node {
    int data;
    Node* left;
    Node* right;

    Node(int value) {
        data = value;
        left = right = nullptr;
    }
};
Node* insert(Node* root, int value) {
    if (root == nullptr) return new Node(value);  // Create new node if tree is empty

    if (value < root->data)
        root->left = insert(root->left, value);   // Go left if value is smaller
    else
        root->right = insert(root->right, value); // Go right if value is larger

    return root;
}

void inorder(Node* root) {
    if (root == nullptr) return;
    inorder(root->left);
    cout << root->data << " ";
    inorder(root->right);
}
void preorder(Node* root) {
    if (root == nullptr) return;
    cout << root->data << " ";
    preorder(root->left);
    preorder(root->right);
}
void postorder(Node* root) {
    if (root == nullptr) return;
    postorder(root->left);
    postorder(root->right);
    cout << root->data << " ";
}
int main() {
    Node* root = nullptr;

    // Inserting elements into the BST
    root = insert(root, 50);
    insert(root, 30);
    insert(root, 70);
    insert(root, 20);
    insert(root, 40);
    insert(root, 60);
    insert(root, 80);
    cout << "In-order traversal: ";
    inorder(root);     // Output: 20 30 40 50 60 70 80

    cout << "Pre-order traversal: ";
    preorder(root);    // Output: 50 30 20 40 70 60 80

    cout << "Post-order traversal: ";
    postorder(root);   // Output: 20 40 30 60 80 70 50

    return 0;
}