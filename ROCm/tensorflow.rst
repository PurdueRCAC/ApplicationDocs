.. _backbone-label:

tensorflow
==============================

Description
~~~~~~~~
TensorFlow is an end-to-end open source platform for machine learning.

Versions
~~~~~~~~
- Bell: 2.5-rocm4.2-dev, 2.7-rocm5.0-dev
- Negishi: 2.5-rocm4.2-dev, 2.7-rocm5.0-dev

Module
~~~~~~~~
You can load the modules by::

    module load rocmcontainers
    module load tensorflow

Example job
~~~~~
.. warning::
    Using ``#!/bin/sh -l`` as shebang in the slurm job script will cause the failure of some biocontainer modules. Please use ``#!/bin/bash`` instead.

To run tensorflow on our clusters::

    #!/bin/bash
    #SBATCH -A myallocation     # Allocation name
    #SBATCH -t 1:00:00
    #SBATCH -N 1
    #SBATCH -n 1
    #SBATCH --job-name=tensorflow
    #SBATCH --mail-type=FAIL,BEGIN,END
    #SBATCH --error=%x-%J-%u.err
    #SBATCH --output=%x-%J-%u.out

    module --force purge
    ml rocmcontainers tensorflow

