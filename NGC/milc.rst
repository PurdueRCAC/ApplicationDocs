.. _backbone-label:

Milc
==============================

Description
~~~~~~~~
MILC represents part of a set of codes written by the MIMD Lattice Computation MILC collaboration used to study quantum chromodynamics QCD, the theory of the strong interactions of subatomic physics. It performs simulations of four dimensional SU3 lattice gauge theory on MIMD parallel machines. \Strong interactions\ are responsible for binding quarks into protons and neutrons and holding them all together in the atomic nucleus.

Versions
~~~~~~~~
- Scholar: quda0.8-patch4Oct2017
- Gilbreth: quda0.8-patch4Oct2017

Module
~~~~~~~~
You can load the modules by::

    module load ngc
    module load milc

Example job
~~~~~
.. warning::
    Using ``#!/bin/sh -l`` as shebang in the slurm job script will cause the failure of some biocontainer modules. Please use ``#!/bin/bash`` instead.

To run milc on our clusters::

    #!/bin/bash
    #SBATCH -A myallocation     # Allocation name
    #SBATCH -t 1:00:00
    #SBATCH -N 1
    #SBATCH -n 1
    #SBATCH --job-name=milc
    #SBATCH --mail-type=FAIL,BEGIN,END
    #SBATCH --error=%x-%J-%u.err
    #SBATCH --output=%x-%J-%u.out

    module --force purge
    ml ngc milc

