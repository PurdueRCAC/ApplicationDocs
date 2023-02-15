.. _backbone-label:

rochpcg
==============================

Description
~~~~~~~~
HPCG is a HPC benchmark intended to better represent computational and data access patterns that closely match a broad set of scientific workloads. This container implements the HPCG benchmark on top of AMDs ROCm platform.

Versions
~~~~~~~~
- Bell: 3.1.0
- Negishi: 3.1.0

Module
~~~~~~~~
You can load the modules by::

    module load rocmcontainers
    module load rochpcg

Example job
~~~~~
.. warning::
    Using ``#!/bin/sh -l`` as shebang in the slurm job script will cause the failure of some biocontainer modules. Please use ``#!/bin/bash`` instead.

To run rochpcg on our clusters::

    #!/bin/bash
    #SBATCH -A myallocation     # Allocation name
    #SBATCH -t 1:00:00
    #SBATCH -N 1
    #SBATCH -n 1
    #SBATCH --job-name=rochpcg
    #SBATCH --mail-type=FAIL,BEGIN,END
    #SBATCH --error=%x-%J-%u.err
    #SBATCH --output=%x-%J-%u.out

    module --force purge
    ml rocmcontainers rochpcg

