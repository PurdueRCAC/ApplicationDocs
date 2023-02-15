.. _backbone-label:

namd
==============================

Description
~~~~~~~~
NAMD is a parallel molecular dynamics code designed for high-performance simulation of large biomolecular systems. NAMD uses the popular molecular graphics program VMD for simulation setup and trajectory analysis, but is also file-compatible with AMBER, CHARMM, and X-PLOR.

Versions
~~~~~~~~
- Scholar: 2.13-multinode, 2.13-singlenode, 3.0-alpha3-singlenode
- Gilbreth: 2.13-multinode, 2.13-singlenode, 3.0-alpha3-singlenode
- Anvil: 2.13-multinode, 2.13-singlenode, 3.0-alpha3-singlenode

Module
~~~~~~~~
You can load the modules by::

    module load ngc
    module load namd

Example job
~~~~~
.. warning::
    Using ``#!/bin/sh -l`` as shebang in the slurm job script will cause the failure of some biocontainer modules. Please use ``#!/bin/bash`` instead.

To run namd on our clusters::

    #!/bin/bash
    #SBATCH -A myallocation     # Allocation name
    #SBATCH -t 1:00:00
    #SBATCH -N 1
    #SBATCH -n 1
    #SBATCH --job-name=namd
    #SBATCH --mail-type=FAIL,BEGIN,END
    #SBATCH --error=%x-%J-%u.err
    #SBATCH --output=%x-%J-%u.out

    module --force purge
    ml ngc namd

