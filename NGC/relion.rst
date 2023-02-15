.. _backbone-label:

relion
==============================

Description
~~~~~~~~
RELION for REgularized LIkelihood OptimizatioN implements an empirical Bayesian approach for analysis of electron cryo-microscopy Cryo-EM. Specifically it provides methods of refinement of singular or multiple 3D reconstructions as well as 2D class averages. RELION is an important tool in the study of living cells.

Versions
~~~~~~~~
- Scholar: 2.1.b1, 3.0.8, 3.1.0, 3.1.2, 3.1.3
- Gilbreth: 2.1.b1, 3.0.8, 3.1.0, 3.1.2, 3.1.3
- Anvil: 2.1.b1, 3.1.0, 3.1.2, 3.1.3

Module
~~~~~~~~
You can load the modules by::

    module load ngc
    module load relion

Example job
~~~~~
.. warning::
    Using ``#!/bin/sh -l`` as shebang in the slurm job script will cause the failure of some biocontainer modules. Please use ``#!/bin/bash`` instead.

To run relion on our clusters::

    #!/bin/bash
    #SBATCH -A myallocation     # Allocation name
    #SBATCH -t 1:00:00
    #SBATCH -N 1
    #SBATCH -n 1
    #SBATCH --job-name=relion
    #SBATCH --mail-type=FAIL,BEGIN,END
    #SBATCH --error=%x-%J-%u.err
    #SBATCH --output=%x-%J-%u.out

    module --force purge
    ml ngc relion

