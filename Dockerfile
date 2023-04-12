# pull latest julia image
FROM --platform=linux/amd64 julia:latest

# create dedicated user
RUN useradd --create-home --shell /bin/bash genie

# set up the app
RUN mkdir /home/genie/app
COPY . /home/genie/app
WORKDIR /home/genie/app

# configure permissions
RUN chown -R genie:genie /home/

RUN chmod +x bin/repl
RUN chmod +x bin/server
RUN chmod +x bin/runtask

# install miniconda3
RUN curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash Miniconda3-latest-Linux-x86_64.sh -b -p /home/USERNAME/miniconda3
RUN /home/USERNAME/miniconda3/bin/conda init
ENV PATH /home/USERNAME/miniconda3/bin:$PATH
RUN conda update -n base conda -y
RUN conda update -n base --all -y
RUN conda install -c conda-forge tmux -y
RUN conda create --name julia python=3.11
RUN conda install -n julia conda -y
RUN conda update -n julia --all -y

# install PyCall + Python packages
COPY ./env/install-pycall-docker.jl .
COPY ./env/python-requirements.txt .
RUN julia install-pycall-docker.jl
RUN conda install --file python-requirements.txt -n julia
RUN rm install-pycall-docker.jl
RUN rm python-requirements.txt

# switch user
USER genie

# instantiate Julia packages
RUN julia -e "using Pkg; Pkg.activate(\".\"); Pkg.instantiate(); Pkg.precompile(); "

# ports
EXPOSE 8000
EXPOSE 80

# set up app environment
ENV JULIA_DEPOT_PATH "/home/genie/.julia"
ENV GENIE_ENV "dev"
ENV GENIE_HOST "0.0.0.0"
ENV PORT "8000"
ENV WSPORT "8000"
ENV EARLYBIND "true"

# run app
CMD ["bin/server"]

# or maybe include a Julia file
# CMD julia -e 'using Pkg; Pkg.activate("."); include("IrisClustering.jl"); '
