.. _backbone-label:

tensorflow
==============================

Description
~~~~~~~~
TensorFlow is an open-source software library for numerical computation using data flow graphs. Nodes in the graph represent mathematical operations, while the graph edges represent the multidimensional data arrays tensors that flow between them. This flexible architecture lets you deploy computation to one or more CPUs or GPUs in a desktop, server, or mobile device without rewriting code.

Versions
~~~~~~~~
- Scholar: 20.02-tf1-py3, 20.02-tf2-py3, 20.03-tf1-py3, 20.03-tf2-py3, 20.06-tf1-py3, 20.06-tf2-py3, 20.11-tf1-py3, 20.11-tf2-py3, 20.12-tf1-py3, 20.12-tf2-py3, 21.06-tf1-py3, 21.06-tf2-py3, 21.09-tf1-py3, 21.09-tf2-py3
- Gilbreth: 20.02-tf1-py3, 20.02-tf2-py3, 20.03-tf1-py3, 20.03-tf2-py3, 20.06-tf1-py3, 20.06-tf2-py3, 20.11-tf1-py3, 20.11-tf2-py3, 20.12-tf1-py3, 20.12-tf2-py3, 21.06-tf1-py3, 21.06-tf2-py3, 21.09-tf1-py3, 21.09-tf2-py3
- Anvil: 20.02-tf1-py3, 20.02-tf2-py3, 20.03-tf1-py3, 20.03-tf2-py3, 20.06-tf1-py3, 20.06-tf2-py3, 20.11-tf1-py3, 20.11-tf2-py3, 20.12-tf1-py3, 20.12-tf2-py3, 21.06-tf1-py3, 21.06-tf2-py3, 21.09-tf1-py3, 21.09-tf2-py3

Module
~~~~~~~~
You can load the modules by::

    module load ngc
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
    #SBATCH -c 8
    #SBATCH --gpus-per-node=1
    #SBATCH --job-name=tensorflow
    #SBATCH --mail-type=FAIL,BEGIN,END
    #SBATCH --error=%x-%J-%u.err
    #SBATCH --output=%x-%J-%u.out

    module --force purge
    ml ngc tensorflow

