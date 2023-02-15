.. _backbone-label:

torchani
==============================

Description
~~~~~~~~
Description

Versions
~~~~~~~~
- Scholar: 2021.04
- Gilbreth: 2021.04
- Anvil: 2021.04

Module
~~~~~~~~
You can load the modules by::

    module load ngc
    module load torchani

Example job
~~~~~
.. warning::
    Using ``#!/bin/sh -l`` as shebang in the slurm job script will cause the failure of some biocontainer modules. Please use ``#!/bin/bash`` instead.

To run torchani on our clusters::

    #!/bin/bash
    #SBATCH -A myallocation     # Allocation name
    #SBATCH -t 1:00:00
    #SBATCH -N 1
    #SBATCH -n 1
    #SBATCH --job-name=torchani
    #SBATCH --mail-type=FAIL,BEGIN,END
    #SBATCH --error=%x-%J-%u.err
    #SBATCH --output=%x-%J-%u.out

    module --force purge
    ml ngc torchani

