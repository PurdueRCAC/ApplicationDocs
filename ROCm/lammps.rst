.. _backbone-label:

lammps
==============================

Description
~~~~~~~~
LAMMPS stands for Large-scale Atomic/Molecular Massively Parallel Simulator and is a classical molecular dynamics MD code.

Versions
~~~~~~~~
- Bell: 2022.5.04
- Negishi: 2022.5.04

Module
~~~~~~~~
You can load the modules by::

    module load rocmcontainers
    module load lammps

Example job
~~~~~
.. warning::
    Using ``#!/bin/sh -l`` as shebang in the slurm job script will cause the failure of some biocontainer modules. Please use ``#!/bin/bash`` instead.

To run lammps on our clusters::

    #!/bin/bash
    #SBATCH -A myallocation     # Allocation name
    #SBATCH -t 1:00:00
    #SBATCH -N 1
    #SBATCH -n 1
    #SBATCH --job-name=lammps
    #SBATCH --mail-type=FAIL,BEGIN,END
    #SBATCH --error=%x-%J-%u.err
    #SBATCH --output=%x-%J-%u.out

    module --force purge
    ml rocmcontainers lammps

