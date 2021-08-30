 # Installing r-base
 

# Installing r-base-dev
After the installation of the core packages, you would typically want to install additional R packages using the `install.packages()` function in R. However, the function depends on the r-base-dev package to compile source code for some R packages. Therefore, prior to using the `install.packages()` function, you should first install the r-base-dev package. Like r-base, the r-base-dev package can be installed in a bash session:

```
sudo apt install r-base-dev
```
Now, you should be able to install most R packages using the install.packages() function in R.

# Installing tidyverse (or other R packages with system dependencies)
You are perhaps aware that, when you install an R package that depends on other uninstalled R package(s), the install.packges() function will automatically install all the required packages at once, even if you don’t explicitly tell it to.

However, things are different when you install an R package that depends on other uninstalled non-R package(s). Under this circumstance, you will always need to manually install the required package(s) before you use the install.packages() function.

A good example would be an R package called tidyverse. In case you don’t know, the tidyverse is a set of R packages (e.g., ggplot2, dplyr, …) developed for data science (e.g., data visualization, data manipulation, …) under a tidy and elegant design philosophy. You can visit the home page for more information.

In short, the tidyverse package requires the following non-R packages: libcurl4-openssl-dev, libssl-dev, libxml2-dev. Like r-base and r-base-dev, you can install them in bash:
```
sudo apt install libcurl4-openssl-dev libssl-dev libxml2-dev
```
Now, you should be able to install tidyverse in R using the install.packages() function:

```
install.packages("tidyverse")
```
# Installing RStudio and RStudio Server

## rstudio server
```
# yum list | grep rstudio
rstudio-server.x86_64                       1.4.1717-1                 @/rstudio-server-rhel-1.4.1717-x86_64

# systemctl status rstudio-server.service
● rstudio-server.service - RStudio Server
   Loaded: loaded (/usr/lib/systemd/system/rstudio-server.service; enabled; vendor preset: disabled)
   Active: active (running) since 월 2021-08-30 14:34:52 KST; 3min 40s ago
  Process: 62493 ExecStart=/usr/lib/rstudio-server/bin/rserver (code=exited, status=0/SUCCESS)
 Main PID: 62494 (rserver)
    Tasks: 3
   Memory: 2.3M
   CGroup: /system.slice/rstudio-server.service
           └─62494 /usr/lib/rstudio-server/bin/rserver

# systemctl restart rstudio-server.service
```

check firewall port

## 버전관리
https://blog.naver.com/PostView.nhn?blogId=cylife3556&logNo=221970778812&parentCategoryNo=&categoryNo=&viewDate=&isShowPopularPosts=false&from=postView
## here package
```
library(here)
#> here() starts at /home/travis/build/r-lib/here
here::here()
#> [1] "/home/travis/build/r-lib/here"
here::here("DESCRIPTION")
#> [1] "/home/travis/build/r-lib/here/DESCRIPTION"
here::here("R", "here.R")
#> [1] "/home/travis/build/r-lib/here/R/here.R"
```


# Reference
- https://blog.zenggyu.com/en/post/2018-01-29/installing-r-r-packages-e-g-tidyverse-and-rstudio-on-ubuntu-linux/
