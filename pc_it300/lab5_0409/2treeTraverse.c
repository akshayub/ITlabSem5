#include <stdio.h>
#include <omp.h>
#include <stdlib.h>
#define max(a,b) a>b?a:b

typedef struct node {
    int data;
    struct node* left;
    struct node* right;
} NODE;

NODE* root = NULL;

NODE* newNode(int data) {
    NODE* temp = (struct node*) malloc(sizeof(NODE));
    temp->data = data;
    temp->left = NULL;
    temp->right = NULL;
    return temp;
}

int search(NODE* root, int k) {

    int left, right;

    if (root == NULL)
        return -1;

    if (root->data == k)
        return 1;

    else {
        #pragma omp task shared(left)
        left = search(root->left,k);

        #pragma omp task shared(right)
        right = search(root->right,k);

        #pragma omp taskwait
        return max(left, right);
    }
}


int main() {
    root = newNode(3);
    root->left = newNode(5);
    root->right = newNode(6);
    root->left->left = newNode(1);
    root->left->right = newNode(2);
    root->right->left = newNode(7);
    root->right->right = newNode(8);

    int ans,key;
    printf("Enter the number to search: ");
    scanf("%d",&key);

    #pragma omp parallel shared(key)
    {
        ans = search(root, key);
    }

    if (ans == 1) {
        printf("Found it!\n");
    }
    else {
        printf("Not found\n");
    }
}
