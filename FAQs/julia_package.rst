Julia package installation
=====================================
Users do not have write permission to the default julia package installation destination. However, users can install packages into home directory under ``~/.julia``.

Users can side step this by explicitly defining where to put julia packages::
        
        $ export JULIA_DEPOT_PATH=$HOME/.julia
        $ julia -e 'using Pkg; Pkg.add("PackageName")'

