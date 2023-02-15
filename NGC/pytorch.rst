.. _backbone-label:

pytorch
==============================

Description
~~~~~~~~
PyTorch is a GPU accelerated tensor computational framework with a Python front end. Functionality can be easily extended with common Python libraries such as NumPy, SciPy, and Cython. Automatic differentiation is done with a tape-based system at both a functional and neural network layer level. This functionality brings a high level of flexibility and speed as a deep learning framework and provides accelerated NumPy-like functionality.

Versions
~~~~~~~~
- Scholar: 20.02-py3, 20.03-py3, 20.06-py3, 20.11-py3, 20.12-py3, 21.06-py3, 21.09-py3
- Gilbreth: 20.02-py3, 20.03-py3, 20.06-py3, 20.11-py3, 20.12-py3, 21.06-py3, 21.09-py3
- Anvil: 20.02-py3, 20.03-py3, 20.06-py3, 20.11-py3, 20.12-py3, 21.06-py3, 21.09-py3

Module
~~~~~~~~
You can load the modules by::

    module load ngc
    module load pytorch

Example job
~~~~~
.. warning::
    Using ``#!/bin/sh -l`` as shebang in the slurm job script will cause the failure of some biocontainer modules. Please use ``#!/bin/bash`` instead.

To run pytorch on our clusters::

    #!/bin/bash
    #SBATCH -A myallocation     # Allocation name
    #SBATCH -t 1:00:00
    #SBATCH -N 1
    #SBATCH -n 1
    #SBATCH --job-name=pytorch
    #SBATCH --mail-type=FAIL,BEGIN,END
    #SBATCH --error=%x-%J-%u.err
    #SBATCH --output=%x-%J-%u.out

    module --force purge
    ml ngc pytorch

