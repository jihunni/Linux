# substitution
```
:%s/[원래문자열]/[바꿀문자열]/[옵션]
```
> option : 
> - g: 해당 문자열에 해당하는 문자열들을 모두 치환하는 옵션  
> - c: 치환하기 전에 매번 치환할지 확인하는 옵션
> - i: 대소문자를 구분하지 않는 옵션  

example
```
tHIS is test string. tHIS is it!
tHIS is second string.
~
~
:%s/This/tHIS/g
```

reference:
- https://twpower.github.io/205-substitute-or-replace-string-in-vi-or-vim