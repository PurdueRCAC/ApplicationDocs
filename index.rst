Scientific Applications on Purdue RCAC Clusters and ACCESS Anvil
==============================================
.. |Anvil| image:: images/anvil.jpg
   :width: 49%

.. |Negishi| image:: images/negishi.jpg
   :width: 49%
|Anvil| |Negishi|


This is the list of Applications, Compilers, MPIs, NVIDIA NGC containers, and AMD ROCm containers deployed on Rosen Center for Advanced Computing (`RCAC`_) clusters (`Negishi`_, `Bell`_, `Gilbreth`_, `Brown`_, `Scholar`_, and `Workbench`_) and ACCESS `Anvil`_. If you want to know what bioinformatics applications are deployed on clusters, please check our `Biocontainers`_ documentation. 

.. _Negishi: https://www.rcac.purdue.edu/compute/negishi
.. _Bell: https://www.rcac.purdue.edu/compute/bell
.. _Brown: https://www.rcac.purdue.edu/compute/brown
.. _Gilbreth: https://www.rcac.purdue.edu/compute/gilbreth
.. _Scholar: https://www.rcac.purdue.edu/compute/scholar
.. _Workbench: https://www.rcac.purdue.edu/compute/workbench
.. _Anvil: https://www.rcac.purdue.edu/anvil
.. _RCAC: https://www.rcac.purdue.edu
.. _Biocontainers: https://biocontainer-doc.readthedocs.io/en/latest/

.. toctree::
   :caption: FAQs
   :titlesonly:
   
   FAQs/AMDgpu
   FAQs/GPUconstraints
   FAQs/hypershell
   FAQs/julia_package
   FAQs/jupyter_kernels
   FAQs/MPI
   FAQs/R

.. toctree::
   :caption: Compilers
   :titlesonly:
   
   Compilers/aocc
   Compilers/gcc
   Compilers/intel-oneapi-compilers
   Compilers/intel

.. toctree::
   :caption: MPIs
   :titlesonly:
   
   MPIs/impi
   MPIs/intel-oneapi-mpi
   MPIs/mvapich2
   MPIs/openmpi

.. toctree::
   :caption: Applications
   :titlesonly:
   
   AMD:
      Applications/amdblis
      Applications/amdfftw
      Applications/amdlibflame
      Applications/amdlibm
      Applications/amdscalapack
      Applications/aocl

   Audio/Visualization:
      Applications/ffmpeg
      Applications/gmt
      Applications/gnuplot
      Applications/paraview
      Applications/tecplot
      Applications/visit
      Applications/vlc
      Applications/vtk

   Bioinformatics:
      Applications/bamtools
      Applications/beagle
      Applications/beast2
      Applications/bismark
      Applications/blast-plus
      Applications/bowtie2
      Applications/bwa
      Applications/cufflinks
      Applications/cutadapt
      Applications/fastqc
      Applications/fasttree
      Applications/fastx-toolkit
      Applications/gatk
      Applications/htseq
      Applications/mrbayes
      Applications/perl-bioperl
      Applications/picard
      Applications/samtools
      Applications/sratoolkit
      Applications/tophat
      Applications/trimmomatic
      Applications/vcftools

   Climate:
      Applications/cdo
      Applications/cplex
      Applications/ncl

   Computational chemistry:
      Applications/amber
      Applications/cp2k
      Applications/gamess
      Applications/gaussian09
      Applications/gaussian16
      Applications/gaussview
      Applications/gromacs
      Applications/lammps
      Applications/namd
      Applications/nwchem
      Applications/quantum-espresso
      Applications/vasp
      Applications/vmd
      Applications/wannier90

   Electrical engineering:
      Applications/sentaurus

   Fluid dynamics:
      Applications/abaqus
      Applications/ansys
      Applications/openfoam

   Geospatial tools:
      Applications/envi
      Applications/gdal
      Applications/geos
      Applications/grads
      Applications/proj

   Libraries:
      Applications/arpack-ng
      Applications/blis
      Applications/boost
      Applications/eigen
      Applications/fftw
      Applications/gmp
      Applications/gsl
      Applications/hdf5
      Applications/hdf
      Applications/intel-mkl
      Applications/intel-oneapi-mkl
      Applications/intel-oneapi-tbb
      Applications/libfabric
      Applications/libflame
      Applications/libiconv
      Applications/libmesh
      Applications/libszip
      Applications/libtiff
      Applications/libv8
      Applications/libx11
      Applications/libxml2
      Applications/mpfr
      Applications/netcdf-c
      Applications/netcdf-cxx4
      Applications/netcdf-fortran
      Applications/netcdf
      Applications/netlib-lapack
      Applications/openblas
      Applications/parallel-netcdf
      Applications/petsc
      Applications/rocm
      Applications/sqlite
      Applications/swig
      Applications/ucx
      Applications/udunits2
      Applications/udunits
      Applications/zlib
      Applications/zstd

   Material science:
      Applications/quantumatk
      Applications/thermocalc

   Mathematical/Statistics:
      Applications/comsol
      Applications/gams
      Applications/gurobi
      Applications/hypre
      Applications/mathematica
      Applications/matlab
      Applications/meep
      Applications/octave
      Applications/r
      Applications/rstudio
      Applications/sas
      Applications/spss
      Applications/stata
      Applications/stata-mp

   ML toolkit:
      Applications/caffe
      Applications/cntk
      Applications/gym
      Applications/keras
      Applications/learning
      Applications/nco
      Applications/opencv
      Applications/py-mpi4py
      Applications/python
      Applications/pytorch
      Applications/spark
      Applications/tensorflow
      Applications/tflearn
      Applications/theano

   NVIDIA:
      Applications/cuda
      Applications/cudnn
      Applications/mxnet
      Applications/nccl
      Applications/nvhpc

   Physics:
      Applications/ansysem

   Programming languages:
      Applications/idl
      Applications/julia
      Applications/tcl

   System:
      Applications/cue-login-env
      Applications/modtree
      Applications/xalt

   Text Editors:
      Applications/vim
      Applications/vscode

   Tools/Utilities:
      Applications/anaconda
      Applications/aws-cli
      Applications/bbftp
      Applications/cmake
      Applications/curl
      Applications/emacs
      Applications/gdb
      Applications/gpaw
      Applications/hadoop
      Applications/hpctoolkit
      Applications/hspice
      Applications/hwloc
      Applications/jupyterhub
      Applications/jupyter
      Applications/launcher
      Applications/monitor
      Applications/mpc
      Applications/ncview
      Applications/numactl
      Applications/openjdk
      Applications/panoply
      Applications/papi
      Applications/parafly
      Applications/protobuf
      Applications/qemu
      Applications/qt
      Applications/subversion
      Applications/texinfo
      Applications/texlive
      Applications/tk
      Applications/totalview
      Applications/valgrind

   Workflow automation:
      Applications/hyper-shell
      Applications/parallel

   Applications/bzip2

.. toctree::
   :caption: NGC
   :titlesonly:
   
   NGC/autodock
   NGC/chroma
   NGC/gamess
   NGC/gromacs
   NGC/julia
   NGC/lammps
   NGC/milc
   NGC/namd
   NGC/nvhpc
   NGC/parabricks
   NGC/paraview
   NGC/pytorch
   NGC/qmcpack
   NGC/quantum_espresso
   NGC/rapidsai
   NGC/relion
   NGC/tensorflow
   NGC/torchani

.. toctree::
   :caption: ROCm
   :titlesonly:
   
   ROCm/cp2k
   ROCm/deepspeed
   ROCm/gromacs
   ROCm/lammps
   ROCm/namd
   ROCm/openmm
   ROCm/pytorch
   ROCm/rochpcg
   ROCm/rochpl
   ROCm/specfem3d_globe
   ROCm/specfem3d
   ROCm/tensorflow

.. toctree::
   :caption: Utilities
   :titlesonly:
   
   Utilities/archivemount
   Utilities/git
   Utilities/grace
   Utilities/monitor
   Utilities/parafly
   Utilities/subversion
   Utilities/vim
   Utilities/visit
   Utilities/vlc

