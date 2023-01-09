# install
Ref : https://www.ks.uiuc.edu/Development/Download/download.cgi


To change the configuration setting (to change the directory to install VMD)
```
$ vi configure
# Name of shell script used to start program; this is the name used by users
$install_name = "vmd";

# Directory where VMD startup script is installed, should be in users' paths.
$install_bin_dir="/opt/vmd/1.9.3/";

# Directory where VMD files and executables are installed
$install_library_dir="/opt/vmd/lib/$install_name";
```

```
$ ./configure
using configure.options: LINUXAMD64 OPENGL OPENGLPBUFFER FLTK TK ACTC CUDA IMD LIBSBALL XINERAMA XINPUT LIBOPTIX LIBOSPRAY LIBTACHYON VRPN NETCDF COLVARS TCL PYTHON PTHREADS NUMPY SILENT ICC
```



To install
```
$ cd src
$ sudo make install
```

To execute
```
$ /opt/vmd/1.9.3/vmd
```

# Analysis
## Graphics
Graphics - Representation - selected molecule - select `Rep` -   
## Trajectory (GROAMCS)
Ref: https://www.youtube.com/watch?v=PlPYc4jMA4c&ab_channel=KushMehta   
File -  New molecule - load `gro` file - load `xtc` or `trr` file   

# Tcl command
- add molecule
  ```
  usage: mol <command> [args...]

  Molecules and Data:
    new [file name] [options...]       -- load file into a new molecule
    new atoms <natoms>                 -- generate a new molecule with 'empty' atoms
    addfile <file name> [options...]   -- load files into existing molecule
      options: type, first, last, step, waitfor, volsets, filebonds, autobonds, 
               <molid> (addfile only)
    load <file type> <file name>       -- load molecule (obsolescent)
    urlload <file type> <URL>          -- load molecule from URL
    pdbload <four letter accession id> -- download molecule from the PDB
    cancel <molid>                     -- cancel load/save of trajectory
    delete <molid>                     -- delete given molecule
    rename <molid> <name>              -- Rename the specified molecule
    dataflag <molid> [set | unset] <flagname> -- Set/unset data output flags
    list [all|<molid>]                 -- displays info about molecules

  Molecule GUI Properties:
    top <molid>                        -- make that molecule 'top'
    on <molid>                         -- make molecule visible
    off <molid>                        -- make molecule invisible
    fix <molid>                        -- don't apply mouse motions
    free <molid>                       -- let mouse move molecules
    active <molid>                     -- make molecule active
    inactive <molid>                   -- make molecule inactive

  Graphical Representations:
    addrep <molid>                     -- add a new representation
    delrep <repid> <molid>             -- delete rep
    default [color | style | selection | material] <value>
    representation|rep <style>         -- set the drawing style for new reps
    selection <selection>              -- set the selection for new reps
    color <color>                      -- set the color for new reps
    material <material>                -- set the material for new reps
    modstyle <repid> <molid> <style>   -- change the drawing style for a rep
    modselect <repid> <molid> <selection>  -- change the selection for a rep
    modcolor <repid> <molid> <color>   -- change the color for a rep
    modmaterial <repid> <molid> <material> -- change the material for a rep
    repname <molid> <repid>            -- Get the name of a rep
    repindex <molid> <repname>         -- Get the repid of a rep from its name
    reanalyze <molid>                  -- Re-analyze structure after changes
    bondsrecalc <molid>                -- Recalculate bonds, current timestep
    ssrecalc <molid>                   -- Recalculate secondary structure (Cartoon)
    selupdate <repid> <molid> [on|off] -- Get/Set auto recalc of rep selection
    colupdate <repid> <molid> [on|off] -- Get/Set auto recalc of rep color
    scaleminmax <molid> <repid> [<min> <max>|auto] -- Get/set colorscale minmax
    drawframes <molid> <repid> [<framespec>|now] -- Get/Set drawn frame range
    smoothrep <molid> <repid> [smooth] -- Get or set trajectory smoothing value
    showperiodic <molid> <repid> [flags] -- Get or set periodic image display
    numperiodic <molid> <repid> <n>    -- Get or set number of periodic images
    showrep <molid> <repid> [on|off]   -- Turn selected rep on or off
    volmove <molid> <matrix> [<volID>] -- transform volumetric data

  Clipping Planes:
    clipplane center <clipid> <repid> <molid> [<vector>]
    clipplane color  <clipid> <repid> <molid> [<vector>]
    clipplane normal <clipid> <repid> <molid> [<vector>]
    clipplane status <clipid> <repid> <molid> [<mode>]
    clipplane num
  ```
  ```
  mol <command> [args]
  mol new [file_name] [options]
    e.g.mol new {molecular_dynamics/relax/AF-F1-model_v4.pdb} type {pdb} first 0 last -1 step 1 waitfor 1
  mol delete []
    e.g. mol delete 0
  ```
- 
