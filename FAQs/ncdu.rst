Disk quota exhausted
============================================
On RCAC clusters, each user's ``$HOME`` only has a quota of 25GB. ``$HOME`` is the ideal place to store important scripts, exectuables, but it should not be used to run jobs and store data of large size. If the quota of ``$HOME`` is exhausted, it will have a big affect and users even cannot submit or run jobs. 


ncdu
~~~~~
RCAC has deployed a nice and easy tool called ``ncdu`` to help users check sizes of files and subdirectories in a specific directory. For example, if users want to check which files/folders occpuy how much disk quota of ``$HOME``, you can easily run ``ncdu`` like this::

        $ ncdu $HOME

You will see results similar to this::

        ncdu 1.17 ~ Use the arrow keys to navigate, press ? for help
        --- /home/zhan4429 -------------------------------------------------------------
          3.3 GiB [###########] /.singularity
          1.4 GiB [####       ] /myapps
          1.1 GiB [###        ] /Fidelity
          776.8 MiB [##         ] /projects
          240.9 MiB [           ] /.local
          177.9 MiB [           ] /R
          174.9 MiB [           ] /git
          113.8 MiB [           ] /Downloads
          107.4 MiB [           ] /.vscode-server
          101.2 MiB [           ] /svn
           72.4 MiB [           ] /spack
           35.4 MiB [           ]  cpu-percent.log
           35.0 MiB [           ] /.celltypist
           33.9 MiB [           ] /Desktop
           32.9 MiB [           ] /alphafold

There are a few hidden directory can occpuy a lot of disk space, including ``~/.cache``, ``~/.conda/pkgs``, and ``.singularity/cache``. Since these folders just contain cache files, it is safe to delete them. 
