R
==============================

Setting Up R Preferences with .Rprofile
~~~~~~~
Different clusters have different hardware and softwares. So, if you have access to multiple clusters, you must install your R packages separately for each cluster. Each cluster has multiple versions of R and packages installed with one version of R may not work with another version of R. So, libraries for each R version must be installed in a separate directory. You can define the directory where your R packages will be installed using the environment variable `R_LIBS_USER`. 

For your convenience, a sample `.Rprofile`_ example file is provided that can be downloaded to your cluster account and renamed into ~/.Rprofile (or appended to one) to customize your installation preferences. Detailed instructions::
        
        curl -#LO https://www.rcac.purdue.edu/files/knowledge/run/examples/apps/r/Rprofile_example
        mv -ib Rprofile_example ~/.Rprofile

The above installation step needs to be done only once on each of the clusters you have access to. Now load the R module and run R to confirm the unique libPaths::
        
        module load r/4.2.2
        R
        R> .libPaths()                  
        [1] "/home/zhan4429/R/bell/4.2.2-gcc-9.3.0-xxbnk6s"                 
        [2] "/apps/spack/bell/apps/r/4.2.2-gcc-9.3.0-xxbnk6s/rlib/R/library"

.. _.Rprofile: https://www.rcac.purdue.edu/files/knowledge/run/examples/apps/r/Rprofile_example 
