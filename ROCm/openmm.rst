.. _backbone-label:

openmm
==============================

Description
~~~~~~~~
OpenMM is a high-performance toolkit for molecular simulation. It can be used as an application, a library, or a flexible programming environment.  OpenMM includes extensive language bindings for Python, C, C++, and even Fortran.  The code is open source and developed on GitHub, licensed under MIT and LGPL.

Versions
~~~~~~~~
- Bell: 7.4.2, 7.7.0
- Negishi: 7.4.2, 7.7.0

Module
~~~~~~~~
You can load the modules by::

    module load rocmcontainers
    module load openmm

Example job
~~~~~
.. warning::
    Using ``#!/bin/sh -l`` as shebang in the slurm job script will cause the failure of some biocontainer modules. Please use ``#!/bin/bash`` instead.

To run openmm on our clusters::

    #!/bin/bash
    #SBATCH -A myallocation     # Allocation name
    #SBATCH -t 1:00:00
    #SBATCH -N 1
    #SBATCH -n 1
    #SBATCH --job-name=openmm
    #SBATCH --mail-type=FAIL,BEGIN,END
    #SBATCH --error=%x-%J-%u.err
    #SBATCH --output=%x-%J-%u.out

    module --force purge
    ml rocmcontainers openmm

