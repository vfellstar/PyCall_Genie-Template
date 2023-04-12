To Create Dockerfile Genie:
> using Pkg; Pkg.add("Genie")
> Genie.Generator.newapp("AppName")
> using Pkg; Pkg.add("GenieDeployDocker")
> using GenieDeployDocker; GenieDeployDocker.dockerfile()

##### ALTER Dockerfile to install PyCall
#
# install miniconda3
#  RUN curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
#  RUN bash Miniconda3-latest-Linux-x86_64.sh -b -p /home/USERNAME/miniconda3
#  RUN /home/USERNAME/miniconda3/bin/conda init
#  ENV PATH /home/USERNAME/miniconda3/bin:$PATH
#  RUN conda update -n base conda -y
#  RUN conda update -n base --all -y
#  RUN conda install -c conda-forge tmux -y
#  RUN conda create --name julia python=3.11
#  RUN conda install -n julia conda -y
#  RUN conda update -n julia --all -y
#
#  # install PyCall + Python packages
#  COPY ./env/install-pycall-docker.jl .
#  COPY ./env/python-requirements.txt .
#  RUN julia install-pycall-docker.jl
#  RUN python -m pip install -r python-requirements.txt
#  RUN rm julia install-pycall-docker.jl
#  RUN rm python-requirements.txt
#
##### ALTER Dockerfile to install PyCall

> GenieDeployDocker.build()
> GenieDeployDocker.run(mountapp = true)


