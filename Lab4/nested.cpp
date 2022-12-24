#include <iostream>

using namespace std;

int main()
{
    for (int i=0;i<8;i++)
    {
        for (int j=0;j<8;j++)
        {
            if (j == i)
            {
                cout << ". ";
            }
            else
                cout << "@ " ;
        }
        cout << "" << endl;
    }
    cout << "" << endl;


    return 0;

}
