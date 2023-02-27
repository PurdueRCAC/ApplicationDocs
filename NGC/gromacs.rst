.. _backbone-label:

gromacs
==============================

Description
~~~~~~~~
GROMACS GROningen MAchine for Chemical Simulations is a molecular dynamics package primarily designed for simulations of proteins, lipids and nucleic acids. It was originally developed in the Biophysical Chemistry department of University of Groningen, and is now maintained by contributors in universities and research centers across the world.

Versions
~~~~~~~~
- Scholar: 2018.2, 2020.2, 2021, 2021.3
- Gilbreth: 2018.2, 2020.2, 2021, 2021.3
- Anvil: 2018.2, 2020.2, 2021, 2021.3

Module
~~~~~~~~
You can load the modules by::

    module load ngc
    module load gromacs

Example job
~~~~~
.. warning::
    Using ``#!/bin/sh -l`` as shebang in the slurm job script will cause the failure of some biocontainer modules. Please use ``#!/bin/bash`` instead.

To run gromacs on our clusters::

    #!/bin/bash
    #SBATCH -A myallocation     # Allocation name
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
    ml ngc gromacs

