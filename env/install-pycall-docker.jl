using Pkg

ENV["PYTHON"] = "" 
ENV["CONDA_JL_HOME"] = "/home/USERNAME/miniconda3/envs/julia"

Pkg.add("PyCall")
Pkg.build("PyCall")

packages = [
    "Genie"
]

Pkg.add(packages)

using PyCall

np=pyimport("numpy")

println("Numpy version: $(np.__version__)")