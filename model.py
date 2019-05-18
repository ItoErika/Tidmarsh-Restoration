# Import
import flopy
import numpy as np

# Name the model
modelname='TW2D1'
mf = flopy.modflow.Modflow(modelname,exe_name='mf2005')

# Model domain and grid definition
Lx = 1000.
Ly = 1000.
ztop = 0.
zbot = -50.
nlay = 1
nrow = 10
ncol = 10
delr = Lx/ncol
delc = Ly/nrow
delv = (ztop - zbot) / nlay
botm = np.linspace(ztop, zbot, nlay + 1)

# CREATE MODEL GRID
# Specify 2D model dimensions
Lx = 20. # Aquifer length in x
Ly = 10. # Aquifer length in y
Lz = 1. # Aquifer length in z
# Spatial discretization
nlay = 50 # Number of grid layers
nrow = 1 # Number of grid rows
ncol = 100 # Number of grid columns
delr = Lx / ncol # Spacing between columns
delc = Ly 
delv = Lz / nlay # Spacing between layers
# Elevation for model surface and layer bottom elevation
model_top = 10. # Elevation of model top 
model_botm = np.linspace(model_top - delv, 0., nlay) # Elevation of model bottom

dis = flopy.modflow.ModflowDis(mf, nlay, nrow, ncol, delr=delr, delc=delc, top=model_top, botm=model_botm)
