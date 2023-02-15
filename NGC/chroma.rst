.. _backbone-label:

chroma
==============================

Description
~~~~~~~~
The Chroma package provides a toolbox and executables to carry out calculation of lattice Quantum Chromodynamics LQCD. It is built on top of the QDP++ QCD Data Parallel Layer which provides an abstract data parallel view of the lattice and provides lattice wide types and expressions, using expression templates, to allow straightforward encoding of LQCD equations.

Versions
~~~~~~~~
- Scholar: 2018-cuda9.0-ubuntu16.04-volta-openmpi, 2020.06, 2021.04
- Gilbreth: 2018-cuda9.0-ubuntu16.04-volta-openmpi, 2020.06, 2021.04

Module
~~~~~~~~
You can load the modules by::

    module load ngc
    module load chroma

Example job
~~~~~
.. warning::
    Using ``#!/bin/sh -l`` as shebang in the slurm job script will cause the failure of some biocontainer modules. Please use ``#!/bin/bash`` instead.

To run chroma on our clusters::

    #!/bin/bash
    #SBATCH -A myallocation     # Allocation name
    #SBATCH -t 1:00:00
    #SBATCH -N 1
    #SBATCH -n 1
    #SBATCH -c 8
    #SBATCH --gpus-per-node=1
    #SBATCH --job-name=chroma
    #SBATCH --mail-type=FAIL,BEGIN,END
    #SBATCH --error=%x-%J-%u.err
    #SBATCH --output=%x-%J-%u.out

    module --force purge
    ml ngc chroma

