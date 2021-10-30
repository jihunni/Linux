# memory structure
Ref: https://developer111.tistory.com/33  
![image](https://user-images.githubusercontent.com/48517782/139520616-6c00fa7a-250b-4d1a-97f3-cffafd762cfc.png)

# Java Error
- File IO error  
	`Exception in thread "main" java.io.FileNotFoundException:`
	  
	**--solution--**  
	check whether the input fire directory is correct, or not.
	  
- OutOfMemoryError: Java heap space  
	`xception in thread "main" java.lang.OutOfMemoryError: Java heap space`  
	Ref : https://docs.oracle.com/javase/7/docs/technotes/tools/windows/java.html#nonstandard  
	Ref : https://alvinalexander.com/blog/post/java/java-xmx-xms-memory-heap-size-control/  
	위의 에러는 heap 영역의 공간이 부족해져서 생긴 오류입니다. 힙 영역의 공간을 늘려주면 해결할 수 있는 부분입니다. 저 또한 메모리가 부족해서 오류가 자주 발생하였지만 일단 중요한거 서버의 메모리가 확보되어있어야 합니다.  
	  
	**--solution--**
	Run Java with the command-line option `-Xmx`, which sets the maximum size of the heap.  
	> -Xmxn : Specifies the maximum size, in bytes, of the memory allocation pool. This value must a multiple of 1024 greater than 2 MB. Append the letter k or K to indicate kilobytes, or m or M to indicate megabytes. The default value is chosen at runtime based on system configuration.
	> For server deployments, -Xms and -Xmx are often set to the same value. See Garbage Collector Ergonomics at http://docs.oracle.com/javase/7/docs/technotes/guides/vm/gc-ergonomics.html
	> Examples:`-Xmx83886080`, `Xmx81920k`, `Xmx80m`
