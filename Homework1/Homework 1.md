## Question 1: 
### First call:
mystery(7,4,-2)
-2 + 7 = 4
current val outside of mystery
a = 5
b = 7
c = -2
### Second call:
mystery(3, -2, 7)
3 + -2 = 7
current val outside of mystery
a = 5
b = 8
c = -2
### Third call:
mystery(8, -2, 13)
13 + 8 = -2
current val outside of memory:
= 5
b = 8
c = -1
## Question 2:
> Check code file
### Question 3: Recursion Output:
#### mystery1(3):

| call | n   | ...       | return |
| ---- | --- | --------- | ------ |
| 1    | 3   | 3 x call2 | 27     |
| 2    | 2   | 3 x call3 | 9      |
| 3    | 1   | 3 x call4 | 3      |
| 4    | 0   | base case | 1      |
#### mystery2(1,4):

| call | m   | n   | ...       | return |
| ---- | --- | --- | --------- | ------ |
| 1    | 1   | 4   | 4 x call2 | 24     |
| 2    | 1   | 3   | 3 x call3 | 6      |
| 3    | 1   | 2   | 2 x call4 | 2      |
| 4    | 1   | 1   | base case | 1      |
#### mystery3(6,4,3):

| call | x   | y   | z   | ...1      | ...2      | return |
| ---- | --- | --- | --- | --------- | --------- | ------ |
| 1    | 6   | 4   | 3   | call2     | 8 x call7 | 16     |
| 2    | 5   | 4   | 3   | call3     | 4 x call6 | 8      |
| 3    | 4   | 4   | 3   | call4     | 2 x call5 | 4      |
| 4    | 3   | 4   | 3   | base case |           | 2      |
| 5    | 4   | 3   | 3   | base case |           | 2      |
| 6    | 5   | 3   | 3   | base case |           | 2      |
| 7    | 6   | 3   | 3   | base case |           | 2      |

#### mystery4(2,2):

| call | x   | y   | ...1       | ...2      | return |
| ---- | --- | --- | ---------- | --------- | ------ |
| 1    | 2   | 2   | call2      | 3 + call5 | 6      |
| 2    | 1   | 2   | call3      | 1 + call4 | 3      |
| 3    | 0   | 2   | base case1 |           | 1      |
| 4    | 1   | 1   | base case2 |           | 2      |
| 5    | 2   | 1   | call6      | 2 + call7 | 3      |
| 6    | 1   | 1   | base case2 |           | 2      |
| 7    | 2   | 0   | base case1 |           | 1      |

#### mystery5(3,2)

| call | x   | y   | ...1       | ...2       | return |
| ---- | --- | --- | ---------- | ---------- | ------ |
| 1    | 3   | 2   | call2      | 6 + call9  | 10     |
| 2    | 2   | 2   | call3      | 3 + call6  | 6      |
| 3    | 1   | 2   | call4      | 1 + call5  | 3      |
| 4    | 0   | 2   | base case1 |            | 1      |
| 5    | 1   | 1   | base case2 |            | 2      |
| 6    | 2   | 1   | call7      | 2 + call8  | 3      |
| 7    | 1   | 1   | base case2 |            | 2      |
| 8    | 2   | 0   | base case1 |            | 1      |
| 9    | 3   | 1   | call10     | 3 + call13 | 4      |
| 10   | 2   | 1   | call11     | 2 + call12 | 3      |
| 11   | 1   | 1   | base case2 |            | 2      |
| 12   | 2   | 0   | base case1 |            | 1      |
| 13   | 3   | 0   | base case1 |            | 1      |

#### mystery6(3):

| call | n   | first call  | second call | print order |
| ---- | --- | ----------- | ----------- | ----------- |
| 1    | 3   | call2 (n-2) | call5 (n-1) | 4           |
| 2    | 1   | call3 (n-2) | call4 (n-1) | 2           |
| 3    | -1  |             |             | 1           |
| 4    | 0   |             |             | 3           |
| 5    | 2   | call6 (n-2) | call7 (n-1) | 6           |
| 6    | 0   |             |             | 5           |
| 7    | 1   | call8 (n-2) | call9       | 8           |
| 8    | -1  |             |             | 7           |
| 9    | 0   |             |             | 9           |
### Output:
-1
1
0
3
0
2
-1
1
0
