# yum
> Yum은 Yellow dog Update라고도 하고 Duke University에서 RPM 설치를 개선하기 위해 개발한 패키지 관리자입니다.   
> Yum은 패키지 저장소를 수요되는 패키지를 검색하고 다운로드 하여 설치까지 처리하면서 패키지들의 의존성을 고려하여 설치할때 패키지 의존성에 대한 error를 줄일 수 있습니다. Red Hat Enterprise Linux 5에서는 Yum으로 패키지를 설치합니다.   
> Yum은 /etc/yum.conf라는 설정파일을 사용합니다. 자세한 내용은 yum(8) man page를 참조해주시길 바랍니다.


1) 패키지 설치:
yum install package  
Example:  
yum install httpd  
2) 패키지 삭제:  
yum remove package  
Example:  
yum remove httpd  
3) 패키지 업데이트:  
yum update package  
Example:  
yum update httpd  
4) 패키지 검색:  
yum search package  
Example:  
yum search httpd  
5) 패키지 정보:  
yum info package  
Example:  
yum info httpd  
6) 특정단어가 포함 된 패키지 리스트:  
yum list term  
Example:  
yum list httpd  
7) 특정 파일을 제공한 패키지 검색:  
yum whatprovides filename  
Example:  
yum whatprovides httpd.conf  
8) 커널 패키지에 설치된 모든 패키지를 업데이트:  
yum -y update  
Example:  
yum -y update  

reference : https://access.redhat.com/ko/solutions/82093
