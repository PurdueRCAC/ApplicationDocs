.. _backbone-label:

specfem3d
==============================

Description
~~~~~~~~
SPECFEM3D Cartesian simulates acoustic fluid, elastic solid, coupled acoustic/elastic, poroelastic or seismic wave propagation in any type of conforming mesh of hexahedra structured or not. It can, for instance, model seismic waves propagating in sedimentary basins or any other regional geological model following earthquakes. It can also be used for non-destructive testing or for ocean acoustics.

Versions
~~~~~~~~
- Bell: 20201122--h9c0626d1
- Negishi: 20201122--h9c0626d1

Module
~~~~~~~~
You can load the modules by::

    module load rocmcontainers
    module load specfem3d

Example job
~~~~~
.. warning::
    Using ``#!/bin/sh -l`` as shebang in the slurm job script will cause the failure of some biocontainer modules. Please use ``#!/bin/bash`` instead.

To run specfem3d on our clusters::

    #!/bin/bash
    #SBATCH -A myallocation     # Allocation name
    #SBATCH -t 1:00:00
    #SBATCH -N 1
    #SBATCH -n 1
    #SBATCH --job-name=specfem3d
    #SBATCH --mail-type=FAIL,BEGIN,END
    #SBATCH --error=%x-%J-%u.err
    #SBATCH --output=%x-%J-%u.out

    module --force purge
    ml rocmcontainers specfem3d

