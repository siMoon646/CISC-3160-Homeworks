void main() { 
    int a = 1, b = 2, c = 3; 
    if (a > b) if (b > c) a = b = c; else c = b = a; else c = a = b;
    IO.println(a + " " + b + " " + c); 
}

