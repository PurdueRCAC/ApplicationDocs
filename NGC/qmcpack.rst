.. _backbone-label:

qmcpack
==============================

Description
~~~~~~~~
QMCPACK is an open-source, high-performance electronic structure code that implements numerous Quantum Monte Carlo algorithms. Its main applications are electronic structure calculations of molecular, periodic 2D and periodic 3D solid-state systems. Variational Monte Carlo VMC, diffusion Monte Carlo DMC and a number of other advanced QMC algorithms are implemented. By directly solving the Schrodinger equation, QMC methods offer greater accuracy than methods such as density functional theory, but at a trade-off of much greater computational expense. Distinct from many other correlated many-body methods, QMC methods are readily applicable to both bulk periodic and isolated molecular systems.

Versions
~~~~~~~~
- Scholar: v3.5.0
- Gilbreth: v3.5.0
- Anvil: v3.5.0

Module
~~~~~~~~
You can load the modules by::

    module load ngc
    module load qmcpack

Example job
~~~~~
.. warning::
    Using ``#!/bin/sh -l`` as shebang in the slurm job script will cause the failure of some biocontainer modules. Please use ``#!/bin/bash`` instead.

To run qmcpack on our clusters::

    #!/bin/bash
    #SBATCH -A myallocation     # Allocation name
    #SBATCH -t 1:00:00
    #SBATCH -N 1
    #SBATCH -n 1
    #SBATCH --job-name=qmcpack
    #SBATCH --mail-type=FAIL,BEGIN,END
    #SBATCH --error=%x-%J-%u.err
    #SBATCH --output=%x-%J-%u.out

    module --force purge
    ml ngc qmcpack

