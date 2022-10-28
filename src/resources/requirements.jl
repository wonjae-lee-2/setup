using Pkg
Pkg.add("Conda") # https://juliahub.com/ui/Packages/Conda/WZE3U/
import Conda
Conda.update()
Conda.add("jupyterlab")
Conda.export_list(joinpath(expanduser(ENV["PROJECT_FOLDER"]), "spec-file.txt"))
