.. _backbone-label:

rochpl
==============================

Description
~~~~~~~~
HPL, or High-Performance Linpack, is a benchmark which solves a uniformly random system of linear equations and reports floating-point execution rate. This container implements the HPL benchmark on top of AMDs ROCm platform.

Versions
~~~~~~~~
- Bell: 5.0.5
- Negishi: 5.0.5

Module
~~~~~~~~
You can load the modules by::

    module load rocmcontainers
    module load rochpl

Example job
~~~~~
.. warning::
    Using ``#!/bin/sh -l`` as shebang in the slurm job script will cause the failure of some biocontainer modules. Please use ``#!/bin/bash`` instead.

To run rochpl on our clusters::

    #!/bin/bash
    #SBATCH -A myallocation     # Allocation name
    #SBATCH -t 1:00:00
    #SBATCH -N 1
    #SBATCH -n 1
    #SBATCH --job-name=rochpl
    #SBATCH --mail-type=FAIL,BEGIN,END
    #SBATCH --error=%x-%J-%u.err
    #SBATCH --output=%x-%J-%u.out

    module --force purge
    ml rocmcontainers rochpl

