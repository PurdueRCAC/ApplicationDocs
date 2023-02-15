.. _backbone-label:

deepspeed
==============================

Description
~~~~~~~~
DeepSpeed is a deep learning optimization library that makes distributed training easy, efficient, and effective.

Versions
~~~~~~~~
- Bell: rocm4.2_ubuntu18.04_py3.6_pytorch_1.8.1
- Negishi: rocm4.2_ubuntu18.04_py3.6_pytorch_1.8.1

Module
~~~~~~~~
You can load the modules by::

    module load rocmcontainers
    module load deepspeed

Example job
~~~~~
.. warning::
    Using ``#!/bin/sh -l`` as shebang in the slurm job script will cause the failure of some biocontainer modules. Please use ``#!/bin/bash`` instead.

To run deepspeed on our clusters::

    #!/bin/bash
    #SBATCH -A gpu
    #SBATCH -t 1:00:00
    #SBATCH -N 1
    #SBATCH -n 1
    #SBATCH -c 8
    #SBATCH --gpus-per-node=1
    #SBATCH --job-name=deepspeed
    #SBATCH --mail-type=FAIL,BEGIN,END
    #SBATCH --error=%x-%J-%u.err
    #SBATCH --output=%x-%J-%u.out

    module --force purge
    ml rocmcontainers deepspeed

