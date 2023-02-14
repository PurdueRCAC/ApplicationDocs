.. _backbone-label:

Specfem3d_globe
==============================

Description
~~~~~~~~
SPECFEM3D Globe simulates global and regional continental-scale seismic wave propagation.

Versions
~~~~~~~~
- Bell: 20210322--h1ee10977
- Negishi: 20210322--h1ee10977

Module
~~~~~~~~
You can load the modules by::

    module load rocmcontainers
    module load specfem3d_globe

Example job
~~~~~
.. warning::
    Using ``#!/bin/sh -l`` as shebang in the slurm job script will cause the failure of some biocontainer modules. Please use ``#!/bin/bash`` instead.

To run specfem3d_globe on our clusters::

    #!/bin/bash
    #SBATCH -A myallocation     # Allocation name
    #SBATCH -t 1:00:00
    #SBATCH -N 1
    #SBATCH -n 1
    #SBATCH --job-name=specfem3d_globe
    #SBATCH --mail-type=FAIL,BEGIN,END
    #SBATCH --error=%x-%J-%u.err
    #SBATCH --output=%x-%J-%u.out

    module --force purge
    ml rocmcontainers specfem3d_globe

