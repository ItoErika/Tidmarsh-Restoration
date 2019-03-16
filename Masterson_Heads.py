# In terminal: 
#pip install https://water.usgs.gov/water-resources/software/FloPy/flopy-3.2.9.zip --upgrade
#python

 
import flopy, os, sys
import matplotlib.pyplot as plt
import numpy as np

os.chdir('C:\\Users\\erikai94\\Documents\\UMass\\Tidmarsh\\Models\\Masterson\\PlymouthCarver')
model_ws = os.path.join('C:\\Users\\erikai94\\Documents\\UMass\\Tidmarsh\\Models\\Masterson\\PlymouthCarver', 'STEADYSTATE', 'modflow_files')
ml = flopy.modflow.Modflow.load('PC_1985_ss.nam', model_ws=model_ws, verbose=True, version='mf2k', check=False)
#ml = flopy.modflow.Modflow.load('PC_2005_ss.nam', model_ws=model_ws, verbose=True, version='mf2005', check=False)


