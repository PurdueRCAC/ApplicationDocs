.. _backbone-label:

namd
==============================

Description
~~~~~~~~
NAMD is a parallel molecular dynamics code designed for high-performance simulation of large biomolecular systems. NAMD uses the popular molecular graphics program VMD for simulation setup and trajectory analysis, but is also file-compatible with AMBER, CHARMM, and X-PLOR.

Versions
~~~~~~~~
- Bell: 2.15a2, 3.0a9
- Negishi: 2.15a2, 3.0a9

Module
~~~~~~~~
You can load the modules by::

    module load rocmcontainers
    module load namd

Example job
~~~~~
.. warning::
    Using ``#!/bin/sh -l`` as shebang in the slurm job script will cause the failure of some biocontainer modules. Please use ``#!/bin/bash`` instead.

To run namd on our clusters::

    #!/bin/bash
    #SBATCH -A gpu
    #SBATCH -t 1:00:00
    #SBATCH -N 1
    #SBATCH -n 1
    #SBATCH -c 8
    #SBATCH --gpus-per-node=1
    #SBATCH --job-name=namd
    #SBATCH --mail-type=FAIL,BEGIN,END
    #SBATCH --error=%x-%J-%u.err
    #SBATCH --output=%x-%J-%u.out

    module --force purge
    ml rocmcontainers namd

