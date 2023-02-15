.. _backbone-label:

gromacs
==============================

Description
~~~~~~~~
GROMACS is a molecular dynamics application designed to simulate Newtonian equations of motion for systems with hundreds to millions of particles. GROMACS is designed to simulate biochemical molecules like proteins, lipids, and nucleic acids that have a lot of complicated bonded interactions.

Versions
~~~~~~~~
- Bell: 2020.3, 2022.3.amd1
- Negishi: 2020.3, 2022.3.amd1

Module
~~~~~~~~
You can load the modules by::

    module load rocmcontainers
    module load gromacs

Example job
~~~~~
.. warning::
    Using ``#!/bin/sh -l`` as shebang in the slurm job script will cause the failure of some biocontainer modules. Please use ``#!/bin/bash`` instead.

To run gromacs on our clusters::

    #!/bin/bash
    #SBATCH -A gpu
    #SBATCH -t 1:00:00
    #SBATCH -N 1
    #SBATCH -n 1
    #SBATCH -c 8
    #SBATCH --gpus-per-node=1
    #SBATCH --job-name=gromacs
    #SBATCH --mail-type=FAIL,BEGIN,END
    #SBATCH --error=%x-%J-%u.err
    #SBATCH --output=%x-%J-%u.out

    module --force purge
    ml rocmcontainers gromacs

