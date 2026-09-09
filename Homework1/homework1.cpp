#include <iostream>
#include <cmath>
using namespace std;

    // Question 2:
void quadratic(double a, double b, double c, double& root1, double& root2){
    root1 = ((-b - sqrt(pow(b,2.0) - 4.0*a*c))/(2.0*a));
    root2 = ((-b + sqrt(pow(b,2.0) - 4.0*a*c))/(2.0*a));
}

int main() {
    // Question 2: 
    double a = 1, b = -3, c = -4, root1 = 0, root2 = 0;
    quadratic(a, b, c, root1, root2);
    cout << a << endl;
    cout << b << endl;
    cout << c << endl;
    cout << root1 << endl;
    cout << root2 << endl;
}
