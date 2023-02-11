# c++ conditional compilation
Ref: https://gyong0.tistory.com/128
if       -> #if  
else if -> #elif  
else    -> #else  

```
#define TEST 1

void main()
{
#if TEST > 0
 cout << "TEST는 0보다 크다." << endl;
#endif
}
```

```
#define ABCD

void main()
{
#ifdef ABCD
  cout << "ABCD는 정의되어 있음" << endl;
#endif
}
```

```
#define ABCD

void main()
{
#ifndef ABCD
  cout << "ABCD는 정의되어 있지 않음" << endl;
#endif
}
```
