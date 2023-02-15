.. _backbone-label:

autodock
==============================

Description
~~~~~~~~
The AutoDock Suite is a growing collection of methods for computational docking and virtual screening, for use in structure-based drug discovery and exploration of the basic mechanisms of biomolecular structure and function.

Versions
~~~~~~~~
- Scholar: 2020.06
- Gilbreth: 2020.06
- Anvil: 2020.06

Module
~~~~~~~~
You can load the modules by::

    module load ngc
    module load autodock

Example job
~~~~~
.. warning::
    Using ``#!/bin/sh -l`` as shebang in the slurm job script will cause the failure of some biocontainer modules. Please use ``#!/bin/bash`` instead.

To run autodock on our clusters::

    #!/bin/bash
    #SBATCH -A myallocation     # Allocation name
    #SBATCH -t 1:00:00
    #SBATCH -N 1
    #SBATCH -n 1
    #SBATCH -c 8
    #SBATCH --gpus-per-node=1
    #SBATCH --job-name=autodock
    #SBATCH --mail-type=FAIL,BEGIN,END
    #SBATCH --error=%x-%J-%u.err
    #SBATCH --output=%x-%J-%u.out

    module --force purge
    ml ngc autodock

