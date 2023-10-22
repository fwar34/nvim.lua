#include <iostream>

using namespace std;

struct node
{
    int data;
    struct node* next;
};

node* reverse(node* link)
{
    node* beg = nullptr;
    node* mid = link;
    node* end = link->next;
    while (true) {
        mid->next = beg;
        if (!end) {
            break;
        }
        beg = mid;
        mid = end;
        end = end->next;
    }
    link = mid;
    return link;
}

void dump(node* link)
{
    node* temp = link;
    while (temp) {
        std::cout << temp->data;
        temp = temp->next;
    }
}

int main()
{
    cout << "xxxxxxx" << endl;
    node n1, n2, n3;
    n1.data = 1;
    n1.next = &n2;
    n2.data = 2;
    n2.next = &n3;
    n3.data = 3;
    n3.next = nullptr;
    dump(&n1);
    node* r = reverse(&n1);
    dump(r);

    return 0;
}
