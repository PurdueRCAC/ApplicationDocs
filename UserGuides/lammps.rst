.. _backbone-label:

Module
~~~~~~~~
You can check available lammps version by::
    module spider lammps
    
You can check how to load the lammps module by the module's full name::
    module spider lammps/XXXX

You can load the modules by::

    module load lammps # for default version
    module load lammps/XXXX # for specific version

Usage
~~~~~~~
LAMMPS reads command lines from an input file like "in.file". The LAMMPS executable is ``lmp``, to run the lammps input file, use the ``-in`` command::
    lmp -in in.file

For more details about how to run LAMMPS, please check `Run LAMMPS`_.

Example job
~~~~~~~
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
~~~~~~
Using ``mpirun -np $SLURM_NTASKS lmp`` or ``mpiexex -np $SLURM_NTASKS lmp`` may not work for non-exclusive jobs on some clusters. Use ``srun -n $SLURM_NTASKS lmp`` or ``mpirun lmp`` instead. ``mpirun lmp`` without specifying the number of ranks will automatically pick up the number of ``SLURM_NTASKS`` and works fine. 

