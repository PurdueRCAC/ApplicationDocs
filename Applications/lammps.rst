.. _backbone-label:

Lammps
==============================

Description
~~~~~~~~
LAMMPS is a classical molecular dynamics code with a focus on materials modelling. It’s an acronym for Large-scale Atomic/Molecular Massively Parallel Simulator.

LAMMPS has potentials for solid-state materials (metals, semiconductors) and soft matter (biomolecules, polymers) and coarse-grained or mesoscopic systems. It can be used to model atoms or, more generically, as a parallel particle simulator at the atomic, meso, or continuum scale.

Versions
~~~~~~~~
- Bell: 20200721, 20201029
- Brown: 7Aug19, 31Mar17
- Scholar: 31Mar17
- Gilbreth: 20190807
- Negishi: 20220623
- Anvil: 20210310, 20210310-kokkos

Module
~~~~~~~

You can check available lammps version by::

    module spider lammps
    
You can check how to load the lammps module by the module's full name::

    module spider lammps/XXXX

You can load the modules by::

    module load lammps # for default version
    module load lammps/XXXX # for specific version

Usage
~~~~~~
LAMMPS reads command lines from an input file like "in.file". The LAMMPS executable is ``lmp``, to run the lammps input file, use the ``-in`` command::

    lmp -in in.file

For more details about how to run LAMMPS, please check `LAMMPS`_.

Example job
~~~~~~
::

    #!/bin/bash
    # FILENAME:  myjobsubmissionfile
    
    #SBATCH --nodes=2       # Total # of nodes 
    #SBATCH --ntasks=256    # Total # of MPI tasks
    #SBATCH --time=1:30:00  # Total run time limit (hh:mm:ss)
    #SBATCH -J myjobname    # Job name
    #SBATCH -o myjob.o%j    # Name of stdout output file
    #SBATCH -e myjob.e%j    # Name of stderr error file

    # Manage processing environment, load compilers and applications.
    module purge
    module load gcc/XXXX openmpi/XXXX # or module load intel/XXXX impi/XXXX | depends on the output of "module spider lammps/XXXX"
    module load lammps/XXXX
    module list

    # Launch MPI code
    srun -n $SLURM_NTASKS lmp

Note
~~~~~
Using ``mpirun -np $SLURM_NTASKS lmp`` or ``mpiexex -np $SLURM_NTASKS lmp`` may not work for non-exclusive jobs on some clusters. Use ``srun -n $SLURM_NTASKS lmp`` or ``mpirun lmp`` instead. ``mpirun lmp`` without specifying the number of ranks will automatically pick up the number of ``SLURM_NTASKS`` and works fine.


.. _LAMMPS: https://docs.lammps.org/Run_head.html


