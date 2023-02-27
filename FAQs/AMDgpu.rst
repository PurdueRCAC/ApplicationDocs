AMD GPUs in Bell and Negishi
==============================

AMD presents a serious rival for Nvidia when it comes to HPC, but Nvidia still maintains the edge for AI acceleration. Nvidia has a more mature programming framework in CUDA. But with AMD's accelerated computing framework (ROCm), AMD is catching up. 

Several nodes of Bell and Negishi are equipped with AMD GPUs. To take advantage of AMD GPU acceleration, applications need to be compatible with AMD GPUs, and built with ROCm. Below are a few usage of AMD GPUs in Bell/Negishi.

PyTorch
#######
Users can need to follow PyTorch installation guide(https://pytorch.org/get-started/locally/) to install PyTorch with AMD GPU support::

        module purge
        module load rocm anaconda/2020.11-py38
        conda create -n torch-rocm
        conda activate torch-rocm
        conda install pytorch torchvision torchaudio -c pytorch

Once the environment is created, you may add the following commands in your job script to activate the environment::

        module purge
        module load rocm anaconda/2020.11-py38
        conda activate torch-rocm


