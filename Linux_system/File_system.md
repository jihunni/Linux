# Linux File System

Question : what's the difference?
/bin/   
/sbin/   
/usr/bin/   
/usr/local/bin/   
/usr/local/sbin/   

Answer   
[link1](https://unix.stackexchange.com/questions/8656/usr-bin-vs-usr-local-bin-on-linux) [link2](https://unix.stackexchange.com/questions/11544/what-is-the-difference-between-opt-and-usr-local) [link3](https://superuser.com/questions/122420/usr-local-or-opt)   
- `/bin` (and `/sbin`) were intended for programs that needed to be on a small / partition before the larger `/usr`, etc. partitions were mounted. These days, it mostly serves as a standard location for key programs like `/bin/sh`, although the original intent may still be relevant for e.g. installations on small embedded devices.
- `/sbin`, as distinct from `/bin`, is for system management programs (not normally used by ordinary users) needed before /usr is mounted.
- `/usr/bin` is for **distribution-managed** normal user programs. 
- There is a `/usr/sbin` with the same relationship to `/usr/bin` as `/sbin` has to `/bin`.
- `/usr/local` : a place to install files built **by the administrator**, and that has to be compiled and installed Unix-styple and compiles to FHS, typically by using the `make` command (e.g., `./configure; make; make install`). The idea is to avoid clashes with files that are part of the operating system, which would either be overwritten or overwrite the local ones otherwise (e.g., `/usr/bin/foo` is part of the OS while `/usr/local/bin/foo` is a local alternative).   All files under `/usr` are shareable between OS instances, although this is rarely done with Linux. This is a part where the FHS is slightly self-contradictory, as `/usr` is defined to be read-only, but `/usr/local/bin` needs to be read-write for local installation of software to succeed. The SVR4 file system standard, which was the FHS' main source of inspiration, is recommending to avoid `/usr/local` and use `/opt/local` instead to overcome this issue.
- `/usr/local/bin` is for normal user programs **not managed by the distribution package manager**, e.g. locally compiled packages. You should not install them into `/usr/bin` because future distribution upgrades may modify or delete them without warning.
- `/usr/local/sbin`, as you can probably guess at this point, is to `/usr/local/bin` as `/usr/sbin` to `/usr/bin`.
- `/opt` : a directory for installing unbundled packages (i.e. **packages not part of the Operating System distribution**, but provided by an independent source), each one in its own subdirectory. (e.g. e.g. a java web-application that comes with it's own applicationserver and loads of resources in a zip archive) They are already built whole packages provided by an independent third party software distributor. Unlike `/usr/local` stuff, these packages follow the directory conventions (or at least they should). For example, `someapp` would be installed in `/opt/someapp`, with one of its command being `/opt/someapp/bin/foo`, its configuration file would be in /`etc/opt/someapp/foo.conf`, and its log files in `/var/opt/someapp/logs/foo.access`. In other word, it is for monolithic non-distribution packages, although before they were properly integrated various distributions put Gnome and KDE there. Generally you should reserve it for large, poorly behaved third party packages such as Oracle.


Comment
- check `man hier`   
- Consider that File system for server uses partision. Each dictory may use different physical disk. For example, `/bin/` and `/usr/local/bin` could use different disk.
