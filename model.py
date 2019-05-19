# Import
import flopy
import numpy as np

# Name the model
modelname='TW2D1'
mf = flopy.modflow.Modflow(modelname,exe_name='mf2005')

# CREATE MODEL GRID
# Specify 2D model dimensions
Lx = 20 # Aquifer length in x (m)
Ly = 1 # Aquifer length in y
Lz = 10 # Aquifer length in z / aquifer thickness (m)
# Spatial discretization
nlay = 50 # Number of grid layers
nrow = 1 # Number of grid rows
ncol = 100 # Number of grid columns
delr = Lx / ncol # Spacing between columns
delc = Ly / nrow
delv = Lz / nlay # Spacing between layers
# Elevation for model surface and layer bottom elevation
model_top = 10. # Elevation of model top 
model_botm = np.linspace(model_top - delv, 0., nlay) # Elevation of model bottom

# Define the DIS package
dis = flopy.modflow.ModflowDis(mf, nlay, nrow, ncol, delr=delr, delc=delc, top=model_top, botm=model_botm)

# Define variables for the BAS package
# Assign an ibound of -1 (constant head) to both sides of the vertical cross section
ibound = np.ones((nlay, nrow, ncol), dtype=np.int32)
ibound[:, :, -1] = -1
ibound[:, :, 0] = -1
# Assign starting head values to both sides of the vertical cross section
strt = np.ones((nlay, nrow, ncol), dtype=np.float32)
strt[:, :, -1] = 10
strt[:, :, 0] = 20

bas = flopy.modflow.ModflowBas(mf, ibound=ibound, strt=strt)
