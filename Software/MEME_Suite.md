# To install MEME Suite

## Prerequisite software
reference : https://meme-suite.org/meme/doc/install.html?man_type=web#parallel

- Perl
   Once Perl is installed run the script dependencies.pl in the scripts directory of the MEME Suite installation files.
   ```
   shell# cd scripts
   shell# perl dependencies.pl

   Checking Required Perl Modules:
   HTML::Template missing.
   HTML::TreeBuilder missing.
   JSON missing.
   Sys::Info missing.

   Checking Optional Modules:
   Log::Log4perl missing. Used for logging and debugging by developers.
   Math::CDF missing. Only required for fasta-enriched-center script (which is not called by the web scripts).
   XML::Compile::SOAP11 missing. Used for downloading sequence databases from RSAT.
   On Ubuntu, you may first need to run 'sudo apt-get install libxml2-dev'
   XML::Compile::WSDL11 missing. Used for downloading sequence databases from RSAT
   XML::Compile::Transport::SOAPHTTP missing. Used for downloading sequence databases from RSAT
   ```
   
   Then install all requirement by using
   ```
   #general
   shell# cpan [list]
   
   #running code
   shell# cpan HTML::Template
   shell# cpan HTML::TreeBuilder
   
   ```

- MPI

## install MEME Suite
file directory : INSTALL
```
1) Type the following commands and then follow the instructions
   printed by the "configure" command.

    $ tar zxf meme_VERSION.tar.gz
    $ cd meme_VERSION 
    $ ./configure --prefix=/opt/MEME_Suite/5.4.1/ --enable-build-libxml2 --enable-build-libxslt --with-mpidir=/opt/OpenMPI/4.1.1/

2) Edit your shell configuration file to add
    "$HOME/meme/bin"
  to your shell's path.
```

```

        ========================
        Configuration parameters
        ========================

  Install path:               /opt/MEME_Suite/5.4.1
  Install UID:
  Version:                    5.4.1
  C compiler:                 gcc
  C compiler flags:           -std=gnu89 -fno-common -Wall -Wno-unused -DUNIX -D__USE_FIXED_PROTOTYPES__   -O3
  Linker:                     /usr/bin/ld -m elf_x86_64
  Special Libs:               -lz -lm
  MPICC:                      /opt/OpenMPI/4.1.1//bin/mpicc
  MPIRUN:                     /opt/OpenMPI/4.1.1//bin/mpirun
  MPI_CMD:                    /opt/OpenMPI/4.1.1//bin/mpirun -np
  MPIINC:                     -DMPI -I/opt/OpenMPI/4.1.1//include
  MPILIBDIR:                  /opt/OpenMPI/4.1.1//lib
  MPIFLAGS:                   -DPARALLEL
  MPI_NPROCS:                 1
  OPAL URL:                   no
  OPAL DEPLOY DIRECTORY:
  BUILD LIBXML2:              yes
  LIBXML2 compiler flags:     -I${top_srcdir}/src/libxml2/include
  LIBXML2 libs:               ${top_builddir}/src/libxml2/libxml2.la
  BUILD LIBXSLT:              yes
  LIBXSLT compiler flags:     -I${top_srcdir}/src/
  LIBXSLT libs:               ${top_builddir}/src/libxslt/libxslt.la
  SOURCE URL:                 https://meme-suite.org
  WEBSITE URL:                https://meme-suite.org/meme
  ALTERNATE WEBSITE URL:
  PREVIOUS VERSION URL:
  PREVIOUS VERSION:
  NOTICES URL:                ./notices.txt
  NEWS URL:                   ./news.txt
  WEBSITE CONTACT:
  DEVELOPER CONTACT:          meme-suite@uw.edu
  GO-SERVER URL:              http://amigo.geneontology.org/amigo/term/GO_TERM_ID
  MEME DB:                    ${datarootdir}/${PACKAGE_NAME}-5.4.1/db
  MEME LOGS:                  ${localstatedir}/${PACKAGE_NAME}-5.4.1/LOGS
  MEME TEMP FILES:
  PERL:                       /usr/bin/perl
  PYTHON:                     /usr/bin/python
  PYTHON VERSiON:             2.7
  CONVERT:
  GHOSTSCRIPT:                /usr/bin/gs
  QUOTA:
  EXPIRY:                     4
  DRMAA QUEUE:
  DRMAA QUEUE SHORT:
  MAXTIME:                    14400
  MAXTIME SHORT:              300
  MAXMEMORY:                  4
  MAXMEMORY SHORT:            1
  STREME LENGTH FACTOR:       1e6

  Run the following commands to compile, test and install meme:
        make
        make test
        make install

  Then make sure that the following two directories are added to
  your PATH variable:
        /opt/MEME_Suite/5.4.1/bin
        /opt/MEME_Suite/5.4.1/libexec/meme-5.4.1

  This can often be done by editing the file named .profile to add
  the following line:
        export PATH=/opt/MEME_Suite/5.4.1/bin:/opt/MEME_Suite/5.4.1/libexec/meme-5.4.1:$PATH


```
