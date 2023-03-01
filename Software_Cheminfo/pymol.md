# Pymol installation on Linux
Ref: https://pymolwiki.org/index.php/Linux_Install
- ubuntu
	```
	apt-get install pymol
	```

# Pymol Install on Mac
Ref: https://pymolwiki.org/index.php/MAC_Install
```
brew install brewsci/bio/pymol
```
```
==> Caveats
==> pymol
To generate movies, run `brew install ffmpeg`.
==> llvm
To use the bundled libc++ please add the following LDFLAGS:
  LDFLAGS="-L/opt/homebrew/opt/llvm/lib/c++ -Wl,-rpath,/opt/homebrew/opt/llvm/lib/c++"

llvm is keg-only, which means it was not symlinked into /opt/homebrew,
because macOS already provides this software and installing another version in
parallel can cause all kinds of trouble.

If you need to have llvm first in your PATH, run:
  echo 'export PATH="/opt/homebrew/opt/llvm/bin:$PATH"' >> ~/.zshrc

For compilers to find llvm you may need to set:
  export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
```
# tutorial
- https://www.pymolwiki.org/index.php/Practical_Pymol_for_Beginners
- http://folding.chemistry.msstate.edu/files/bootcamp/2021/session-09_pymol-tutorial.pdf
- 
# Command
	```
	seq_view, 0 # seq_view set to off.
	seq_view, 1 # seq_view set to on.
	```
