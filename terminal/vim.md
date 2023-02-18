# search
ref : https://overcode.tistory.com/entry/vi-%EC%97%90%EC%84%9C-%EB%AC%B8%EC%9E%90%EC%97%B4-%EA%B2%80%EC%83%89
general code
```
:/string
```

running code
```
/찾을문자열
```


# substitution
reference:
- https://twpower.github.io/205-substitute-or-replace-string-in-vi-or-vim
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

# macro
Ref: 
- http://aboutmadlife.blogspot.com/2014/09/linux-vi-macro.html
- https://coldmater.tistory.com/226

`q{레지스터}` 로 매크로 기록 시작  
`q` 로 매크로 기록 종료  
`@{레지스터}` 로 저장된 매크로 실행  
`@@` 로 직전에 실행한 매크로 재실행  
`{반복횟수}@{레지스터}` 또는 `{반복횟수}@@` 로 저장된 매크로를 '반복횟수' 만큼 재실행  
