```
#check curl version
$ curl --version

# -C 옵션을 통해 이어 받기 할 수 있다.
$ curl -C - -o file_name.txt https://^_^.com/some_text.txt
```
> -C 옵션을 사용해 이어받기를 할 수 있다. 중요한건 -C뒤에 -를 붙여야한다.

```
# 연속된 URL 로 요청하고 결과 파일로 지정하기
$ curl "https://example_url/[000001-000188].m4s" -o "#1.m4s"
```
> → https://example_url/000001.m4s~000188.m4s 까지 연속적으로 접속해서 결과를 000001.m4s ~ 000184.m4s로 저장. curl로 네이버나 카카오TV의 동영상 받을 때 유용합니다.


# reference 
- https://hackinglife.tistory.com/182
