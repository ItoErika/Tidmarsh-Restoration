# -*- coding: utf-8 -*-
"""
Created on Sun Sep 15 18:41:42 2019

@author: erikai94
"""
# Example taken from: https://github.com/GeostatsGuy/PythonNumericalDemos/blob/master/GeostatsPy_sisim.ipynb

import os                                                 
import numpy as np                                      
import pandas as pd  
import scipy as scipy
import scipy.integrate as integrate                                     
import matplotlib.pyplot as plt                           
import geostatspy.GSLIB as GSLIB
import pygslib as gslib
from matplotlib.pyplot import figure
import geostatspy.geostats as geostats

os.chdir("C:/Users/erikai94/Documents/UMass/Tidmarsh/Models/geostats")  

df = pd.read_csv("FakeFaciesData.csv")             # read a .csv file in as a DataFrame
df.describe()                                             # summary statistics 

###################################################################################
#################################### Functions ####################################
###################################################################################
# Function to expand simulations in x and y directions
def expand(x, y): 
    temp=np.zeros((np.size(x,0),y*np.size(x,1)));
    for i in range(np.size(x,0)):
        temp[i,]=np.repeat(x[i,:],y)

    
    sim_ex=np.zeros((y*np.size(temp,0),np.size(temp,1)))
    for i in range(np.size(temp,1)):
        sim_ex[:,i]=np.repeat(temp[:,i],y)
        
    return sim_ex
  
# Function to crop simulations to create hummock topography
def humcrop(sim, ymax, height): 
    sim2=sim[0:(ymax+height),:];
    for i in dist:
        sim2[0:(ymax+height)-top_surf_int[i],i]=np.nan     
    return sim2

####################################################################################
##################################### NO MICROTOPO #################################
####################################################################################    

####################################################################################
####################### H / 25 peat / 75 sand / No hummocks  #######################
####################################################################################
# Sequential Indicator Simulation with Simple Kriging Multiple Realizations 
# A: 0.2488 / 0.7512  = PEAT / SAND
# B: 0.2536 / 0.7464
# C: 0.2477 / 0.7524
# D: 0.2578 / 0.7422    
# Original A:  0.7484 / 0.25160000000000005
nx = 500; ny = 10; xsiz =1; ysiz = 1; xmn = 0.5; ymn = 0.5; nxdis = 1; nydis = 1
ndmin = 0; ndmax = 10; nodmax = 10; radius =25; skmean = 0
tmin = -999; tmax = 999
dummy_trend = np.zeros((10,10))            # the current version requires trend input - if wrong size it is ignored 

ncut = 2                                   # number of facies
thresh = [0,1]                             # the facies categories (use consisten order)
gcdf = [0.25,0.75]                         # the global proportions of the categories
varios = []                                # the variogram list
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=90,hmaj1=25,hmin1=8))# peat indicator variogram
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=90,hmaj1=25,hmin1=8))# sand indicator variogram


#sim25flatA = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
#               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
#               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 64987,
#               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)


sim25flatA = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 61025,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim25flatB = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 64901,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim25flatC = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 64355,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim25flatD = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 64367,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)
       
plt.hist(sim25flatA.flatten(),bins=2,density=True,cumulative = True,alpha=0.1,color='red',edgecolor='black')
plt.hist(sim25flatB.flatten(),bins=2,density=True,cumulative = True,alpha=0.1,color='red',edgecolor='black')
plt.hist(sim25flatC.flatten(),bins=2,density=True,cumulative = True,alpha=0.1,color='red',edgecolor='black')
plt.hist(sim25flatD.flatten(),bins=2,density=True,cumulative = True,alpha=0.1,color='red',edgecolor='black')

# Expand the simulation by a factor of 4
sim25flat_exA = expand(sim25flatA,4)
sim25flat_exB = expand(sim25flatB,4)
sim25flat_exC = expand(sim25flatC,4)
sim25flat_exD = expand(sim25flatD,4)

plt.figure(figsize=(20*1.8395879323031639,0.40*1.8410852713178292))                                    # plot the results
fig=plt.imshow(sim25flat_exA, cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim25flat_ink_A.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

plt.figure(figsize=(20*1.8395879323031639,0.40*1.8410852713178292))                                    # plot the results
fig=plt.imshow(sim25flat_exB, cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim25flat_ink_B.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

plt.figure(figsize=(20*1.8395879323031639,0.40*1.8410852713178292))                                    # plot the results
fig=plt.imshow(sim25flat_exC, cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim25flat_ink_C.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

plt.figure(figsize=(20*1.8395879323031639,0.40*1.8410852713178292))                                    # plot the results
fig=plt.imshow(sim25flat_exD, cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim25flat_ink_D.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulation
plt.figure(figsize=(20,0.40))                                    # plot the results
fig=plt.imshow(sim25flat_exA, cmap='Greys_r')
plt.savefig('sim25flat_A.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulation
plt.figure(figsize=(20,0.40))                                    # plot the results
fig=plt.imshow(sim25flat_exB, cmap='Greys_r')
plt.savefig('sim25flat_B.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulation
plt.figure(figsize=(20,0.40))                                    # plot the results
fig=plt.imshow(sim25flat_exC, cmap='Greys_r')
plt.savefig('sim25flat_C.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulation
plt.figure(figsize=(20,0.40))                                    # plot the results
fig=plt.imshow(sim25flat_exD, cmap='Greys_r')
plt.savefig('sim25flat_D.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)


####################################################################################
####################### V / 25 peat / 75 sand / No hummocks  #######################
####################################################################################
# Sequential Indicator Simulation with Simple Kriging Multiple Realizations 
# A: 0.2452 / 0.7548 = PEAT / SAND
# B: 0.2434 / 0.7566
# C: 0.2540 / 0.7460

nx = 500; ny = 10; xsiz =1; ysiz = 1; xmn = 0.5; ymn = 0.5; nxdis = 1; nydis = 1
ndmin = 0; ndmax = 10; nodmax = 10; radius =25; skmean = 0
tmin = -999; tmax = 999
dummy_trend = np.zeros((10,10))            # the current version requires trend input - if wrong size it is ignored 

ncut = 2                                   # number of facies
thresh = [0,1]                             # the facies categories (use consisten order)
gcdf = [0.25,0.75]                         # the global proportions of the categories
varios = []                                # the variogram list
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=180,hmaj1=25,hmin1=8))# peat indicator variogram
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=180,hmaj1=25,hmin1=8))# sand indicator variogram


sim25flatAv = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 67189,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim25flatBv = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 67533,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)
               
sim25flatCv = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 67155,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)
               
# 67377, 67115, 67331, 67391, 67513, 67327

plt.hist(sim25flatAv.flatten(),bins=2,density=True,cumulative = True,alpha=0.1,color='red',edgecolor='black')
plt.hist(sim25flatBv.flatten(),bins=2,density=True,cumulative = True,alpha=0.1,color='red',edgecolor='black')
plt.hist(sim25flatCv.flatten(),bins=2,density=True,cumulative = True,alpha=0.1,color='red',edgecolor='black')

# Expand the simulation by a factor of 4
sim25flat_exAv = expand(sim25flatAv,4)
sim25flat_exBv = expand(sim25flatBv,4)
sim25flat_exCv = expand(sim25flatCv,4)

# Plot the simulations for the dxf conversion
plt.figure(figsize=(20*1.8395879323031639,0.40*1.8410852713178292))                                    # plot the results
fig=plt.imshow(sim25flat_exAv, cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim25flat_ink_Av.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

plt.figure(figsize=(20*1.8395879323031639,0.40*1.8410852713178292))                                    # plot the results
fig=plt.imshow(sim25flat_exBv, cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim25flat_ink_Bv.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

plt.figure(figsize=(20*1.8395879323031639,0.40*1.8410852713178292))                                    # plot the results
fig=plt.imshow(sim25flat_exCv, cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim25flat_ink_Cv.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulations for potential figures
plt.figure(figsize=(20,0.40))                                    # plot the results
fig=plt.imshow(sim25flat_exAv, cmap='Greys_r')
plt.savefig('sim25flat_Av.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulation
plt.figure(figsize=(20,0.40))                                    # plot the results
fig=plt.imshow(sim25flat_exBv, cmap='Greys_r')
plt.savefig('sim25flat_Bv.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulation
plt.figure(figsize=(20,0.40))                                    # plot the results
fig=plt.imshow(sim25flat_exCv, cmap='Greys_r')
plt.savefig('sim25flat_Cv.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)


####################################################################################
####################### H / 50 peat / 50 sand / No hummocks  #######################
####################################################################################
# Sequential Indicator Simulation with Simple Kriging Multiple Realizations 
# A: 0.5020 / 0.4980 = PEAT/SAND
# B: 0.4933 / 0.5067
# C: 0.5015 / 0.4985

nx = 500; ny = 15; xsiz =1; ysiz = 1; xmn = 0.5; ymn = 0.5; nxdis = 1; nydis = 1
ndmin = 0; ndmax = 10; nodmax = 10; radius =25; skmean = 0
tmin = -999; tmax = 999
dummy_trend = np.zeros((10,10))            # the current version requires trend input - if wrong size it is ignored 

ncut = 2                                   # number of facies
thresh = [0,1]                             # the facies categories (use consisten order)
gcdf = [0.50,0.50]                           # the global proportions of the categories
varios = []                                # the variogram list
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=90,hmaj1=25,hmin1=8)) # shale indicator variogram
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=90,hmaj1=25,hmin1=8))#sand indicator variogram


sim50flatA = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 67577,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim50flatB = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 67163,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim50flatC = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 67587,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

# 64519, 65119, 67503, 67325, 67179, 67147, 67337, 64967, 64949, 62175  

plt.hist(sim50flatA.flatten(),bins=2,density=True,cumulative = True,alpha=0.1,color='red',edgecolor='black')
plt.hist(sim50flatB.flatten(),bins=2,density=True,cumulative = True,alpha=0.1,color='red',edgecolor='black')
plt.hist(sim50flatC.flatten(),bins=2,density=True,cumulative = True,alpha=0.1,color='red',edgecolor='black')

# Expand the simulation by a factor of 4
sim50flat_exA = expand(sim50flatA,4)
sim50flat_exB = expand(sim50flatB,4)
sim50flat_exC = expand(sim50flatC,4)

# Plot the simulations for the dxf conversion
plt.figure(figsize=(20*1.8395879323031639,0.60*1.8410852713178292))                                    # plot the results
fig=plt.imshow(sim50flat_exA, cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim50flat_ink_A.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

plt.figure(figsize=(20*1.8395879323031639,0.60*1.8410852713178292))                                    # plot the results
fig=plt.imshow(sim50flat_exB, cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
# Save as a png
plt.savefig('sim50flat_ink_B.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

plt.figure(figsize=(20*1.8395879323031639,0.60*1.8410852713178292))                                    # plot the results
fig=plt.imshow(sim50flat_exC, cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim50flat_ink_C.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulations for potential figures
plt.figure(figsize=(20,0.60))                                    # plot the results
fig=plt.imshow(sim50flat_exA, cmap='Greys_r')
plt.savefig('sim50flat_A.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulation
plt.figure(figsize=(20,0.60))                                    # plot the results
fig=plt.imshow(sim50flat_exB, cmap='Greys_r')
plt.savefig('sim50flat_B.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulation
plt.figure(figsize=(20,0.60))                                    # plot the results
fig=plt.imshow(sim50flat_exC, cmap='Greys_r')
plt.savefig('sim50flat_C.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

####################################################################################
####################### V / 50 peat / 50 sand / No hummocks  #######################
####################################################################################
# Sequential Indicator Simulation with Simple Kriging Multiple Realizations 
# A: 0.4941 / 0.5059 = PEAT/SAND
# B: 0.5083 / 0.4917
# C: 0.4909 / 0.5091

nx = 500; ny = 15; xsiz =1; ysiz = 1; xmn = 0.5; ymn = 0.5; nxdis = 1; nydis = 1
ndmin = 0; ndmax = 10; nodmax = 10; radius =25; skmean = 0
tmin = -999; tmax = 999
dummy_trend = np.zeros((10,10))            # the current version requires trend input - if wrong size it is ignored 

ncut = 2                                   # number of facies
thresh = [0,1]                             # the facies categories (use consisten order)
gcdf = [0.50,0.50]                         # the global proportions of the categories
varios = []                                # the variogram list
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=180,hmaj1=25,hmin1=8)) # peat indicator variogram
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=180,hmaj1=25,hmin1=8)) # sand indicator variogram


sim50flatAv = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 65199,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim50flatBv = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 65079,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim50flatCv = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 65123,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)
               

# Expand the simulation by a factor of 4
sim50flat_exAv = expand(sim50flatAv,4)
sim50flat_exBv = expand(sim50flatBv,4)
sim50flat_exCv = expand(sim50flatCv,4)

# Plot the simulations for the dxf conversion
plt.figure(figsize=(20*1.8395879323031639,0.60*1.8410852713178292))                                    # plot the results
fig=plt.imshow(sim50flat_exAv, cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim50flat_ink_Av.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

plt.figure(figsize=(20*1.8395879323031639,0.60*1.8410852713178292))                                    # plot the results
fig=plt.imshow(sim50flat_exBv, cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim50flat_ink_Bv.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

plt.figure(figsize=(20*1.8395879323031639,0.60*1.8410852713178292))                                    # plot the results
fig=plt.imshow(sim50flat_exCv, cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim50flat_ink_Cv.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulations for potential figures
plt.figure(figsize=(20,0.60))                                    # plot the results
fig=plt.imshow(sim50flat_exAv, cmap='Greys_r')
plt.savefig('sim50flat_Av.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulation
plt.figure(figsize=(20,0.60))                                    # plot the results
fig=plt.imshow(sim50flat_exBv, cmap='Greys_r')
plt.savefig('sim50flat_Bv.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulation
plt.figure(figsize=(20,0.60))                                    # plot the results
fig=plt.imshow(sim50flat_exCv, cmap='Greys_r')
plt.savefig('sim50flat_Cv.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

####################################################################################
####################### H / 75 peat / 25 sand / No hummocks  #######################
####################################################################################
# Sequential Indicator Simulation with Simple Kriging Multiple Realizations 
# A: 0.7523 / 0.2477 
# B: 0.7435 / 0.2565
# C: 0.7518 / 0.2482

nx = 500; ny = 30; xsiz =1; ysiz = 1; xmn = 0.5; ymn = 0.5; nxdis = 1; nydis = 1
ndmin = 0; ndmax = 10; nodmax = 10; radius =25; skmean = 0
tmin = -999; tmax = 999
dummy_trend = np.zeros((10,10))            # the current version requires trend input - if wrong size it is ignored 

ncut = 2                                   # number of facies
thresh = [0,1]                             # the facies categories (use consisten order)
gcdf = [0.75,0.25]                         # the global proportions of the categories
varios = []                                # the variogram list
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=90,hmaj1=25,hmin1=8)) # peat indicator variogram
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=90,hmaj1=25,hmin1=8)) # sand indicator variogram

sim75flatA = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 64969,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim75flatB = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 65001,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim75flatC = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 64519,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)
               
# 65079, 65127, 67163, 67587, 65127, 67163, 67587, 64937, 64955, 64977, 65041, 65065, 65081, 65099, 65175

plt.hist(sim75flatA.flatten(),bins=2,density=True,cumulative = True,alpha=0.1,color='red',edgecolor='black')
plt.hist(sim75flatB.flatten(),bins=2,density=True,cumulative = True,alpha=0.1,color='red',edgecolor='black')
plt.hist(sim75flatC.flatten(),bins=2,density=True,cumulative = True,alpha=0.1,color='red',edgecolor='black')

# Expand the simulation by a factor of 4
sim75flat_exA = expand(sim75flatA,4)
sim75flat_exB = expand(sim75flatB,4)
sim75flat_exC = expand(sim75flatC,4)

# Plot the simulations for the dxf conversion
plt.figure(figsize=(20*1.8395879323031639,1.2*1.8410852713178292))                                    # plot the results
fig=plt.imshow(simfl75at_exA, cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim75flat_ink_A.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulations for the dxf conversion
plt.figure(figsize=(20*1.8395879323031639,1.2*1.8410852713178292))                                    # plot the results
fig=plt.imshow(sim75flat_exA, cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim75flat_ink_A.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

plt.figure(figsize=(20*1.8395879323031639,1.2*1.8410852713178292))                                    # plot the results
fig=plt.imshow(sim75flat_exB, cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim75flat_ink_B.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

plt.figure(figsize=(20*1.8395879323031639,1.2*1.8410852713178292))                                    # plot the results
fig=plt.imshow(sim75flat_exC, cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim75flat_ink_C.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulations for potential figures
plt.figure(figsize=(20,1.2))                                    # plot the results
fig=plt.imshow(sim75flat_exA, cmap='Greys_r')
# Save as a png
plt.savefig('sim75flat_A.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulation
plt.figure(figsize=(20,1.2))                                    # plot the results
fig=plt.imshow(sim75flat_exB, cmap='Greys_r')
plt.savefig('sim75flat_B.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulation
plt.figure(figsize=(20,1.2))                                    # plot the results
fig=plt.imshow(sim75flat_exC, cmap='Greys_r')
plt.savefig('sim75flat_C.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

####################################################################################
####################### V / 75 peat / 25 sand / No hummocks  #######################
####################################################################################
# Sequential Indicator Simulation with Simple Kriging Multiple Realizations 
# A: 0.7421 / 0.2579 = PEAT / SAND
# B: 0.7563 / 0.2437
# C: 0.7545 / 0.2455

nx = 500; ny = 30; xsiz =1; ysiz = 1; xmn = 0.5; ymn = 0.5; nxdis = 1; nydis = 1
ndmin = 0; ndmax = 10; nodmax = 10; radius =25; skmean = 0
tmin = -999; tmax = 999
dummy_trend = np.zeros((10,10))            # the current version requires trend input - if wrong size it is ignored 

ncut = 2                                   # number of facies
thresh = [0,1]                             # the facies categories (use consisten order)
gcdf = [0.75,0.25]                         # the global proportions of the categories
varios = []                                # the variogram list
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=180,hmaj1=25,hmin1=8)) # peat indicator variogram
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=180,hmaj1=25,hmin1=8)) # sand indicator variogram


sim75flatAv = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 64947,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim75flatBv = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 64997,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim75flatCv = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 65081,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

# 65103, 64961

plt.hist(sim75flatAv.flatten(),bins=2,density=True,cumulative = True,alpha=0.1,color='red',edgecolor='black')
plt.hist(sim75flatBv.flatten(),bins=2,density=True,cumulative = True,alpha=0.1,color='red',edgecolor='black')
plt.hist(sim75flatCv.flatten(),bins=2,density=True,cumulative = True,alpha=0.1,color='red',edgecolor='black')

# Expand the simulation by a factor of 4
sim75flat_exAv = expand(sim75flatAv,4)
sim75flat_exBv = expand(sim75flatBv,4)
sim75flat_exCv = expand(sim75flatCv,4)

# Plot the simulations for the dxf conversion
plt.figure(figsize=(20*1.8395879323031639,1.2*1.8410852713178292))                                    # plot the results
fig=plt.imshow(sim75flatAv, cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim75flat_ink_Av.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

plt.figure(figsize=(20*1.8395879323031639,1.2*1.8410852713178292))                                    # plot the results
fig=plt.imshow(sim75flat_exBv, cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim75flat_ink_Bv.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

plt.figure(figsize=(20*1.8395879323031639,1.2*1.8410852713178292))                                    # plot the results
fig=plt.imshow(sim75flat_exCv, cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim75flat_ink_Cv.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulations for potential figures
plt.figure(figsize=(20,1.2))                                    # plot the results
fig=plt.imshow(sim75flat_exAv, cmap='Greys_r')
# Save as a png
plt.savefig('sim75flat_Av.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulation
plt.figure(figsize=(20,1.2))                                    # plot the results
fig=plt.imshow(sim75flat_exBv, cmap='Greys_r')
plt.savefig('sim75flat_Bv.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulation
plt.figure(figsize=(20,1.2))                                    # plot the results
fig=plt.imshow(sim75flat_exCv, cmap='Greys_r')
plt.savefig('sim75flat_Cv.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

####################################################################################
###################################### MICROTOPO ###################################
####################################################################################    

####################################################################################
######################### H / 25 peat / 75 sand / hummocks  ########################
############################ 20 cm height / 25 cm width ############################
####################################################################################
# Sequential Indicator Simulation with Simple Kriging Multiple Realizations 
# A: 0.2421 / 0.7579 = PEAT / SAND
# B: 0.2453 / 0.7547
# C: 0.2528 / 0.7472

nx = 500; ny = 13; xsiz =1; ysiz = 1; xmn = 0.5; ymn = 0.5; nxdis = 1; nydis = 1
ndmin = 0; ndmax = 10; nodmax = 10; radius =25; skmean = 0
tmin = -999; tmax = 999
dummy_trend = np.zeros((10,10))            # the current version requires trend input - if wrong size it is ignored 

ncut = 2                                   # number of facies
thresh = [0,1]                             # the facies categories (use consisten order)
gcdf = [0.25,0.75]                         # the global proportions of the categories
varios = []                                # the variogram list
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=90,hmaj1=25,hmin1=8)) # shale indicator variogram
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=90,hmaj1=25,hmin1=8))#sand indicator variogram

sim25hum2025A = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 75309,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim25hum2025B = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 75667,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim25hum2025C = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 67373,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

# 75667, 64959, 75309, 75627, 75629, 67373, 65959, 65983, 75951, 63045, 75633, 75635, 75695

# Expand the simulation by a factor of 4
sim25hum2025_exA = expand(sim25hum2025A,4)
sim25hum2025_exB = expand(sim25hum2025B,4)
sim25hum2025_exC = expand(sim25hum2025C,4)

# Make hummocks
dist  = np.arange(0, sim25hum2025_exA.shape[1], 1)  # Assign sine wave x values (1 per cm)
hum_h=10                                            # Define hummock height (in cm)
hum_p=50                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+40   # Create sine wave for hummocky top surface
bot_surf = np.repeat(0, sim25hum2025_exA.shape[1])
# Plot a sine wave using time and amplitude obtained for the sine wave
#plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 

#def integrand(dist):
#    return (hum_h*np.sin((2/hum_p)*np.pi*dist)+40)
#integrate.quad(integrand, 0, 2000)

# Plot and save surfaces for COMSOL import
plt.figure(figsize=(20*1.8395879323031639,0.50*1.8410852713178292))                                    # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.axis('off')
plt.savefig('hum2025.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Round each element in the top and bottom surface array to the nearest integer
top_surf_int=np.rint(top_surf).astype(int)
#bot_surf_int=np.rint(bot_surf).astype(int)

# Make a copy of the simulation to removes hummocks from
#sim25hum2025_exA2=sim25hum2025_exA[0:50,:]
# Remove the area above hummocky top surface frpm the geostatistical simulations
#for i in dist:
#   sim25hum2025_exA2[0:50-top_surf_int[i],i]=np.nan   

# Make a copy of the simulation to removes hummocks from
#sim25hum2025_exB2=sim25hum2025_exB[0:50,:]
# Remove the area above hummocky top surface frpm the geostatistical simulations
#for i in dist:
#   sim25hum2025_exB2[0:50-top_surf_int[i],i]=np.nan   
   
# Make a copy of the simulation to removes hummocks from
#sim25hum2025_exC2=sim25hum2025_exC[0:50,:]
# Remove the area above hummocky top surface frpm the geostatistical simulations
#for i in dist:
#   sim25hum2025_exC2[0:50-top_surf_int[i],i]=np.nan

# Make a copy of the simulation to removes hummocks from

# Plot the simulations for the dxf conversion
plt.figure(figsize=(20,0.5))                                    # plot the results
fig=plt.imshow(sim25hum2025_exA[0:50,:], cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim25hum2025_ink_A.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

plt.figure(figsize=(20,0.5))                                    # plot the results
fig=plt.imshow(sim25hum2025_exB[0:50,:], cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim25hum2025_ink_B.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

plt.figure(figsize=(20,0.5))                                    # plot the results
fig=plt.imshow(sim25hum2025_exC[0:50,:], cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim25hum2025_ink_C.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulations for potential figures
plt.figure(figsize=(20,0.50))                                    # plot the results
fig=plt.imshow(sim25hum2025_exA, cmap='Greys_r')
# Save as a png
plt.savefig('sim25hum2025_A.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulation
plt.figure(figsize=(20,0.50))                                    # plot the results
fig=plt.imshow(sim25hum2025_exB, cmap='Greys_r')
# Save as a png
plt.savefig('sim25hum2025_B.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulation
plt.figure(figsize=(20,0.50))                                    # plot the results
fig=plt.imshow(sim25hum2025_exC, cmap='Greys_r')
# Save as a png
plt.savefig('sim25hum2025_C.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

####################################################################################
######################### H / 50 peat / 50 sand / hummocks  ########################
############################ 20 cm height / 25 cm width ############################
####################################################################################
# Sequential Indicator Simulation with Simple Kriging Multiple Realizations 
# A: 0.4947 / 0.5053 = PEAT / SAND
# B: 0.4983 / 0.5017
# C: 0.4919 / 0.5082
# D: 0.4908 / 0.5093

nx = 500; ny = 18; xsiz =1; ysiz = 1; xmn = 0.5; ymn = 0.5; nxdis = 1; nydis = 1
ndmin = 0; ndmax = 10; nodmax = 10; radius =25; skmean = 0
tmin = -999; tmax = 999
dummy_trend = np.zeros((10,10))            # the current version requires trend input - if wrong size it is ignored 

ncut = 2                                   # number of facies
thresh = [0,1]                             # the facies categories (use consisten order)
gcdf = [0.50,0.50]                         # the global proportions of the categories
varios = []                                # the variogram list
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=90,hmaj1=25,hmin1=8)) # shale indicator variogram
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=90,hmaj1=25,hmin1=8))#sand indicator variogram


sim50hum2025A = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 67315,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim50hum2025B = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 67363,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim50hum2025C = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 75135,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim50hum2025D = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 65343,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

# 65343
# 65973, 75309, 61063, 61087
# 65351, 65381, 65901, 67335, 75917, 75971, 75361

# Expand the simulation by a factor of 4
sim50hum2025_exA = expand(sim50hum2025A,4)
sim50hum2025_exB = expand(sim50hum2025B,4)
sim50hum2025_exC = expand(sim50hum2025C,4)
sim50hum2025_exD = expand(sim50hum2025D,4)


# Make hummocks
dist  = np.arange(0, sim50hum2025_exA.shape[1], 1)  # Assign sine wave x values (1 per cm)
hum_h=10                                            # Define hummock height (in cm)
hum_p=50                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+60   # Create sine wave for hummocky top surface
bot_surf = np.repeat(0, sim50hum2025_exA.shape[1])
# Plot a sine wave using time and amplitude obtained for the sine wave
#plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 

#def integrand(dist):
#    return (hum_h*np.sin((2/hum_p)*np.pi*dist)+60)
#integrate.quad(integrand, 0, 2000)

# Plot and save surfaces for COMSOL import
plt.figure(figsize=(20*1.8395879323031639,0.70*1.8410852713178292))                                    # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.axis('off')
plt.savefig('hum2025.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Round each element in the top and bottom surface array to the nearest integer
top_surf_int=np.rint(top_surf).astype(int)
#bot_surf_int=np.rint(bot_surf).astype(int)

# Make a copy of the simulation to removes hummocks from
#sim50hum2025_exA2=sim50hum2025_exA[0:70,:]
# Remove the area above hummocky top surface frpm the geostatistical simulations
#for i in dist:
#   sim50hum2025_exA2[0:70-top_surf_int[i],i]=np.nan   

# Make a copy of the simulation to removes hummocks from
#sim50hum2025_exB2=sim50hum2025_exB[0:70,:]
# Remove the area above hummocky top surface frpm the geostatistical simulations
#for i in dist:
#   sim50hum2025_exB2[0:70-top_surf_int[i],i]=np.nan   
   
# Make a copy of the simulation to removes hummocks from
#sim50hum2025_exC2=sim50hum2025_exC[0:70,:]
# Remove the area above hummocky top surface frpm the geostatistical simulations
#for i in dist:
#   sim50hum2025_exC2[0:70-top_surf_int[i],i]=np.nan

# Plot the simulations for the dxf conversion
plt.figure(figsize=(20,0.7))                                    # plot the results
fig=plt.imshow(sim50hum2025_exA[0:70,:], cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim50hum2025_ink_A.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

plt.figure(figsize=(20,0.7))                                    # plot the results
fig=plt.imshow(sim50hum2025_exB[0:70,:], cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim50hum2025_ink_B.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

plt.figure(figsize=(20,0.7))                                    # plot the results
fig=plt.imshow(sim50hum2025_exC[0:70,:], cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim50hum2025_ink_C.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

plt.figure(figsize=(20,0.7))                                    # plot the results
fig=plt.imshow(sim50hum2025_exD[0:70,:], cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim50hum2025_ink_D.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulations for potential figures
plt.figure(figsize=(20,0.70))                                    # plot the results
fig=plt.imshow(sim50hum2025_exA, cmap='Greys_r')
# Save as a png
plt.savefig('sim50hum2025_A.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulation
plt.figure(figsize=(20,0.70))                                    # plot the results
fig=plt.imshow(sim50hum2025_exB, cmap='Greys_r')
# Save as a png
plt.savefig('sim50hum2025_B.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulation
plt.figure(figsize=(20,0.70))                                    # plot the results
fig=plt.imshow(sim50hum2025_exC, cmap='Greys_r')
# Save as a png
plt.savefig('sim50hum2025_C.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulation
plt.figure(figsize=(20,0.70))                                    # plot the results
fig=plt.imshow(sim50hum2025_exD, cmap='Greys_r')
# Save as a png
plt.savefig('sim50hum2025_D.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)


####################################################################################
######################### H / 75 peat / 25 sand / hummocks  ########################
############################ 20 cm height / 25 cm width ############################
####################################################################################
# Sequential Indicator Simulation with Simple Kriging Multiple Realizations 
# A: 0.7476 / 0.2524 = PEAT / SAND
# B: 0.7451 / 0.2549
# C: 0.7577 / 0.2423

nx = 500; ny = 33; xsiz =1; ysiz = 1; xmn = 0.5; ymn = 0.5; nxdis = 1; nydis = 1
ndmin = 0; ndmax = 10; nodmax = 10; radius =25; skmean = 0
tmin = -999; tmax = 999
dummy_trend = np.zeros((10,10))            # the current version requires trend input - if wrong size it is ignored 

ncut = 2                                   # number of facies
thresh = [0,1]                             # the facies categories (use consisten order)
gcdf = [0.75,0.25]                         # the global proportions of the categories
varios = []                                # the variogram list
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=90,hmaj1=25,hmin1=8)) # sand indicator variogram
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=90,hmaj1=25,hmin1=8)) # peat indicator variogram

sim75hum2025A = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 65007,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim75hum2025B = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 65975,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim75hum2025C = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 75145,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim75hum2025D = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 65979,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

# PICK B, C, AND D
# 65971, 65979, 67345, 65019, 65063, 65323, 65339, 65385, 61003, 61057, 61077, 61085, 63023, 63027, 63057, 63071
# 63515, 63571, 75603, 75619, 75699

# Expand the simulation by a factor of 4
sim75hum2025_exA = expand(sim75hum2025A,4)
sim75hum2025_exB = expand(sim75hum2025B,4)
sim75hum2025_exC = expand(sim75hum2025C,4)
sim75hum2025_exD = expand(sim75hum2025D,4)

# Make hummocks
dist  = np.arange(0, sim75hum2025_exA.shape[1], 1)  # Assign sine wave x values (1 per cm)
hum_h=10                                            # Define hummock height (in cm)
hum_p=50                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+120   # Create sine wave for hummocky top surface
bot_surf = np.repeat(0, sim75hum2025_exA.shape[1])
# Plot a sine wave using time and amplitude obtained for the sine wave
#plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 

#def integrand(dist):
#    return (hum_h*np.sin((2/hum_p)*np.pi*dist)+120)
#integrate.quad(integrand, 0, 2000)

# Plot and save surfaces for COMSOL import
plt.figure(figsize=(20,1.30))                                    # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.axis('off')
plt.savefig('hum2025.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Round each element in the top and bottom surface array to the nearest integer
top_surf_int=np.rint(top_surf).astype(int)
#bot_surf_int=np.rint(bot_surf).astype(int)

sim75hum2025_exA2=humcrop(sim75hum2025_exA, 120, 10)
sim75hum2025_exB2=humcrop(sim75hum2025_exB, 120, 10)
sim75hum2025_exC2=humcrop(sim75hum2025_exC, 120, 10)
sim75hum2025_exD2=humcrop(sim75hum2025_exD, 120, 10)

# Plot the simulations for the dxf conversion
plt.figure(figsize=(20,1.3))                                    # plot the results
fig=plt.imshow(sim75hum2025_exA[0:130,:], cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim75hum2025_ink_A.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

plt.figure(figsize=(20,1.3))                                    # plot the results
fig=plt.imshow(sim75hum2025_exB[0:130,:], cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim75hum2025_ink_B.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

plt.figure(figsize=(20,1.3))                                    # plot the results
fig=plt.imshow(sim75hum2025_exC[0:130,:], cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim75hum2025_ink_C.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

plt.figure(figsize=(20,1.3))                                    # plot the results
fig=plt.imshow(sim75hum2025_exD[0:130,:], cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim75hum2025_ink_D.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)


# Plot the simulations for potential figures
plt.figure(figsize=(20,1.3))                                    # plot the results
fig=plt.imshow(sim75hum2025_exA2, cmap='Greys_r')
# Save as a png
plt.savefig('sim75hum2025_A.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulation
plt.figure(figsize=(20,1.3))                                    # plot the results
fig=plt.imshow(sim75hum2025_exB2, cmap='Greys_r')
# Save as a png
plt.savefig('sim75hum2025_B.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulation
plt.figure(figsize=(20,1.30))                                    # plot the results
fig=plt.imshow(sim75hum2025_exC2, cmap='Greys_r')
# Save as a png
plt.savefig('sim75hum2025_C.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulation
plt.figure(figsize=(20,1.30))                                    # plot the results
fig=plt.imshow(sim75hum2025_exD2, cmap='Greys_r')
# Save as a png
plt.savefig('sim75hum2025_D.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)


####################################################################################
######################### H / 25 peat / 75 sand / hummocks  ########################
############################ 20 cm height / 100 cm width ############################
####################################################################################
# Sequential Indicator Simulation with Simple Kriging Multiple Realizations 
# A:  = PEAT / SAND
# B: 
# C: 

nx = 500; ny = 13; xsiz =1; ysiz = 1; xmn = 0.5; ymn = 0.5; nxdis = 1; nydis = 1
ndmin = 0; ndmax = 10; nodmax = 10; radius =25; skmean = 0
tmin = -999; tmax = 999
dummy_trend = np.zeros((10,10))            # the current version requires trend input - if wrong size it is ignored 

ncut = 2                                   # number of facies
thresh = [0,1]                             # the facies categories (use consisten order)
gcdf = [0.25,0.75]                         # the global proportions of the categories
varios = []                                # the variogram list
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=90,hmaj1=25,hmin1=8)) # shale indicator variogram
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=90,hmaj1=25,hmin1=8))#sand indicator variogram

sim25hum20100A = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 63013,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim25hum20100B = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 61065,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim25hum20100C = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 63549,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios) 

# 61029, 61047, 63013, 61065, 63549, 65335, 65975


# Expand the simulation by a factor of 4
sim25hum20100_exA = expand(sim25hum20100A,4)
sim25hum20100_exB = expand(sim25hum20100B,4)
sim25hum20100_exC = expand(sim25hum20100C,4)

# Make hummocks
dist  = np.arange(0, sim25hum20100_exA.shape[1], 1)  # Assign sine wave x values (1 per cm)
hum_h=10                                             # Define hummock height (in cm)
hum_p=200                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+40   # Create sine wave for hummocky top surface
bot_surf = np.repeat(0, sim25hum20100_exA.shape[1])
# Plot a sine wave using time and amplitude obtained for the sine wave
#plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 

#def integrand(dist):
#    return (hum_h*np.sin((2/hum_p)*np.pi*dist)+40)
#integrate.quad(integrand, 0, 2000)

# Plot and save surfaces for COMSOL import
plt.figure(figsize=(20,1.30))                                    # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.axis('off')
plt.savefig('hum2025.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Round each element in the top and bottom surface array to the nearest integer
top_surf_int=np.rint(top_surf).astype(int)
#bot_surf_int=np.rint(bot_surf).astype(int)

sim25hum20100_exA2=humcrop(sim25hum20100_exA, 40, 10)
sim25hum20100_exB2=humcrop(sim25hum20100_exB, 40, 10)
sim25hum20100_exC2=humcrop(sim25hum20100_exC, 40, 10)

# Plot the simulations for the dxf conversion
plt.figure(figsize=(20,0.5))                                    # plot the results
fig=plt.imshow(sim25hum20100_exA[0:50,:], cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim25hum20100_ink_A.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

plt.figure(figsize=(20,0.5))                                    # plot the results
fig=plt.imshow(sim25hum20100_exB[0:50,:], cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim25hum20100_ink_B.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

plt.figure(figsize=(20,0.5))                                    # plot the results
fig=plt.imshow(sim25hum20100_exC[0:50,:], cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim25hum20100_ink_C.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulations for potential figures
plt.figure(figsize=(20,0.5))                                    # plot the results
fig=plt.imshow(sim25hum20100_exA2, cmap='Greys_r')
# Save as a png
plt.savefig('sim25hum20100_A.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulation
plt.figure(figsize=(20,0.5))                                    # plot the results
fig=plt.imshow(sim25hum20100_exB2, cmap='Greys_r')
# Save as a png
plt.savefig('sim25hum20100_B.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulation
plt.figure(figsize=(20,0.5))                                    # plot the results
fig=plt.imshow(sim25hum20100_exC2, cmap='Greys_r')
# Save as a png
plt.savefig('sim25hum20100_C.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)




####################################################################################
######################### V / 25 peat / 75 sand / hummocks  ########################
############################ 20 cm height / 100 cm width ############################
####################################################################################
# Sequential Indicator Simulation with Simple Kriging Multiple Realizations 
# A:  = PEAT / SAND
# B: 
# C: 

nx = 500; ny = 13; xsiz =1; ysiz = 1; xmn = 0.5; ymn = 0.5; nxdis = 1; nydis = 1
ndmin = 0; ndmax = 10; nodmax = 10; radius =25; skmean = 0
tmin = -999; tmax = 999
dummy_trend = np.zeros((10,10))            # the current version requires trend input - if wrong size it is ignored 

ncut = 2                                   # number of facies
thresh = [0,1]                             # the facies categories (use consisten order)
gcdf = [0.25,0.75]                         # the global proportions of the categories
varios = []                                # the variogram list
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=180,hmaj1=25,hmin1=8)) # shale indicator variogram
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=180,hmaj1=25,hmin1=8))#sand indicator variogram

sim25hum20100A = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 63013,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim25hum20100B = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 61065,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim25hum20100C = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 63549,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios) 

# Expand the simulation by a factor of 4
sim25hum20100_exA = expand(sim25hum20100A,4)
sim25hum20100_exB = expand(sim25hum20100B,4)
sim25hum20100_exC = expand(sim25hum20100C,4)

# Make hummocks
dist  = np.arange(0, sim25hum20100_exA.shape[1], 1)  # Assign sine wave x values (1 per cm)
hum_h=10                                             # Define hummock height (in cm)
hum_p=200                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+40   # Create sine wave for hummocky top surface
bot_surf = np.repeat(0, sim25hum20100_exA.shape[1])
# Plot a sine wave using time and amplitude obtained for the sine wave
#plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 

#def integrand(dist):
#    return (hum_h*np.sin((2/hum_p)*np.pi*dist)+40)
#integrate.quad(integrand, 0, 2000)

# Plot and save surfaces for COMSOL import
plt.figure(figsize=(20,1.30))                                    # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.axis('off')
plt.savefig('hum2025.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Round each element in the top and bottom surface array to the nearest integer
top_surf_int=np.rint(top_surf).astype(int)
#bot_surf_int=np.rint(bot_surf).astype(int)

sim25hum20100_exA2=humcrop(sim25hum20100_exA, 40, 10)
sim25hum20100_exB2=humcrop(sim25hum20100_exB, 40, 10)
sim25hum20100_exC2=humcrop(sim25hum20100_exC, 40, 10)

# Plot the simulations for the dxf conversion
plt.figure(figsize=(20,0.5))                                    # plot the results
fig=plt.imshow(sim25hum20100_exA[0:50,:], cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim25hum20100_ink_A.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

plt.figure(figsize=(20,0.5))                                    # plot the results
fig=plt.imshow(sim25hum20100_exB[0:50,:], cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim25hum20100_ink_B.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

plt.figure(figsize=(20,0.5))                                    # plot the results
fig=plt.imshow(sim25hum20100_exC[0:50,:], cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
plt.savefig('sim25hum20100_ink_C.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulations for potential figures
plt.figure(figsize=(20,0.5))                                    # plot the results
fig=plt.imshow(sim25hum20100_exA2, cmap='Greys_r')
# Save as a png
plt.savefig('sim25hum20100_A.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulation
plt.figure(figsize=(20,0.5))                                    # plot the results
fig=plt.imshow(sim25hum20100_exB2, cmap='Greys_r')
# Save as a png
plt.savefig('sim25hum20100_B.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Plot the simulation
plt.figure(figsize=(20,0.5))                                    # plot the results
fig=plt.imshow(sim25hum20100_exC2, cmap='Greys_r')
# Save as a png
plt.savefig('sim25hum20100_C.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)












































############################################################
# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=10                                            # Define hummock height (in cm)
hum_p=50                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+40   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,0.50*1.8410852713178292))                                    # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.axis('off')
plt.savefig('hum1025_25PEAT.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=10                                            # Define hummock height (in cm)
hum_p=50                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+60   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,0.70*1.8410852713178292))                                    # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.axis('off')
plt.savefig('hum1025_50PEAT.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=10                                            # Define hummock height (in cm)
hum_p=50                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+120   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,1.3*1.8410852713178292))                                    # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.axis('off')
plt.savefig('hum1025_75PEAT.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)


############################################################

# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=10                                            # Define hummock height (in cm)
hum_p=50                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+60   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,0.70*1.8410852713178292))                                    # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.axis('off')
plt.savefig('hum1025_50PEAT.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=10                                            # Define hummock height (in cm)
hum_p=50                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+120   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,1.3*1.8410852713178292))                                    # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.axis('off')
plt.savefig('hum1025_75PEAT.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)










############################################################
# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=10                                            # Define hummock height (in cm)
hum_p=50                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+40   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,0.50*1.8410852713178292))  
plt.margins(0)                                  # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum20_25_25PEAT.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=10                                            # Define hummock height (in cm)
hum_p=50                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+60   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,0.70*1.8410852713178292))   
plt.margins(0)                                  # plot the results                                 # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum20_25_50PEAT.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=10                                            # Define hummock height (in cm)
hum_p=50                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+120   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,1.3*1.8410852713178292))   
plt.margins(0)                                  # plot the results                                 # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum20_25_75PEAT.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)


# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=10                                            # Define hummock height (in cm)
hum_p=200                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+40   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,0.50*1.8410852713178292))    
plt.margins(0)                                  # plot the results                                # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum20_100_25PEAT.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=10                                            # Define hummock height (in cm)
hum_p=200                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+60   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,0.70*1.8410852713178292))    
plt.margins(0)                                  # plot the results                                # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum20_100_50PEAT.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=10                                            # Define hummock height (in cm)
hum_p=200                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+120   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,1.3*1.8410852713178292))        
plt.margins(0)                                  # plot the results                            # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum20_100_75PEAT.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)


# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=10                                            # Define hummock height (in cm)
hum_p=1000                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+40   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,0.50*1.8410852713178292))     
plt.margins(0)                                  # plot the results                               # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum20_500_25PEAT.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=10                                            # Define hummock height (in cm)
hum_p=1000                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+60   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,0.70*1.8410852713178292))      
plt.margins(0)                                  # plot the results                              # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum20_500_50PEAT.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=10                                            # Define hummock height (in cm)
hum_p=1000                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+120   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,1.3*1.8410852713178292))     
plt.margins(0)                                  # plot the results                               # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum20_500_75PEAT.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)













############################################################
# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=50                                            # Define hummock height (in cm)
hum_p=50                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+40   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,1.0*1.8410852713178292))  
plt.margins(0)                                  # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum100_25_25PEAT.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=50                                            # Define hummock height (in cm)
hum_p=50                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+60   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,1.0*1.8410852713178292))   
plt.margins(0)                                  # plot the results                                 # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum100_25_50PEAT.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=50                                            # Define hummock height (in cm)
hum_p=50                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+120   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,1.5*1.8410852713178292))   
plt.margins(0)                                  # plot the results                                 # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum100_25_75PEAT.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

#PROP
# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=50                                            # Define hummock height (in cm)
hum_p=250                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+40   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,1.0*1.8410852713178292))  
plt.margins(0)                                  # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum100_25_25PEAT_prop.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=50                                            # Define hummock height (in cm)
hum_p=250                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+60   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,1.0*1.8410852713178292))   
plt.margins(0)                                  # plot the results                                 # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum100_25_50PEAT_prop.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=50                                            # Define hummock height (in cm)
hum_p=250                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+120   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,1.5*1.8410852713178292))   
plt.margins(0)                                  # plot the results                                 # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum100_25_75PEAT_prop.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)


############################################################
# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=50                                            # Define hummock height (in cm)
hum_p=200                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+40   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,1.0*1.8410852713178292))  
plt.margins(0)                                  # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum100_100_25PEAT.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=50                                            # Define hummock height (in cm)
hum_p=200                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+60   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,1.0*1.8410852713178292))   
plt.margins(0)                                  # plot the results                                 # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum100_100_50PEAT.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=50                                            # Define hummock height (in cm)
hum_p=200                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+120   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,1.5*1.8410852713178292))   
plt.margins(0)                                  # plot the results                                 # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum100_100_75PEAT.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

#PROP
# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=50                                            # Define hummock height (in cm)
hum_p=1000                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+40   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,1.0*1.8410852713178292))  
plt.margins(0)                                  # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum100_500_25PEAT_prop.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=50                                            # Define hummock height (in cm)
hum_p=1000                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+60   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,1.0*1.8410852713178292))   
plt.margins(0)                                  # plot the results                                 # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum100_500_50PEAT_prop.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=50                                            # Define hummock height (in cm)
hum_p=1000                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+120   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,1.5*1.8410852713178292))   
plt.margins(0)                                  # plot the results                                 # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum100_500_75PEAT_prop.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)


############################################################
# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=50                                            # Define hummock height (in cm)
hum_p=1000                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+40   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,1.0*1.8410852713178292))  
plt.margins(0)                                  # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum100_500_25PEAT.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=50                                            # Define hummock height (in cm)
hum_p=1000                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+60   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,1.0*1.8410852713178292))   
plt.margins(0)                                  # plot the results                                 # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum100_500_50PEAT.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=50                                            # Define hummock height (in cm)
hum_p=1000                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+120   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,1.5*1.8410852713178292))   
plt.margins(0)                                  # plot the results                                 # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum100_500_75PEAT.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

#PROP
# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=50                                            # Define hummock height (in cm)
hum_p=5000                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+40   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,1.0*1.8410852713178292))  
plt.margins(0)                                  # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum100_500_25PEAT_prop.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=50                                            # Define hummock height (in cm)
hum_p=1000                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+60   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,1.0*1.8410852713178292))   
plt.margins(0)                                  # plot the results                                 # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum100_500_50PEAT_prop.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=50                                            # Define hummock height (in cm)
hum_p=1000                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+120   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,1.5*1.8410852713178292))   
plt.margins(0)                                  # plot the results                                 # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum100_500_75PEAT_prop.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)













# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=10                                            # Define hummock height (in cm)
hum_p=200                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+40   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,0.50*1.8410852713178292))    
plt.margins(0)                                  # plot the results                                # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum20_100_25PEAT.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=10                                            # Define hummock height (in cm)
hum_p=200                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+60   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,0.70*1.8410852713178292))    
plt.margins(0)                                  # plot the results                                # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum20_100_50PEAT.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=10                                            # Define hummock height (in cm)
hum_p=200                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+120   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,1.3*1.8410852713178292))        
plt.margins(0)                                  # plot the results                            # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum20_100_75PEAT.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)


# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=10                                            # Define hummock height (in cm)
hum_p=800                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+40   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,0.50*1.8410852713178292))     
plt.margins(0)                                  # plot the results                               # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum20_400_25PEAT.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=10                                            # Define hummock height (in cm)
hum_p=800                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+60   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,0.70*1.8410852713178292))      
plt.margins(0)                                  # plot the results                              # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum20_400_50PEAT.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=10                                            # Define hummock height (in cm)
hum_p=800                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+120   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,1.3*1.8410852713178292))     
plt.margins(0)                                  # plot the results                               # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('hum20_400_75PEAT.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)












# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=10                                            # Define hummock height (in cm)
hum_p=200                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+40   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,0.60*1.8410852713178292))                                    # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.axis('off')
plt.savefig('hum1025.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Make hummocks
dist  = np.arange(0, 2000, 1)  # Assign sine wave x values (1 per cm)
hum_h=10                                            # Define hummock height (in cm)
hum_p=50                                            # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+40   # Create sine wave for hummocky top surface
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)
# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = np.repeat(0,2000)
plt.figure(figsize=(20*1.8395879323031639,0.60*1.8410852713178292))                                    # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.axis('off')
plt.savefig('hum1025.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)






# Make hummocks
dist  = np.arange(0, sim25hum1025_exA.shape[1], 1)  # Assign sine wave x values (1 per cm)
hum_h=40                                            # Define hummock height (in cm)
hum_p=200                                        # Define hummock period 
top_surf  = hum_h*np.sin((2/hum_p)*np.pi*dist)+50   # Create sine wave for hummocky top surface 

# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(dist, top_surf)

# Create a disturbed peat surface to match the hummock geometry
# Create cosine wave for disturbed bottom surface 
bot_surf  = hum_h*np.cos((2/hum_p)*np.pi*dist-0.7)+10
def integrand(dist):
    return (hum_h*np.sin((2/hum_p)*np.pi*dist)+50)- (hum_h*np.cos((2/hum_p)*np.pi*dist-0.5)+10)
integrate.quad(integrand, 0, 2000)

plt.figure(figsize=(20*1.8395879323031639,1*1.8410852713178292))                                    # plot the results
fig=plt.plot(dist, bot_surf, 'k', linewidth=0.5)
plt.plot(dist, top_surf, 'k', linewidth=0.5)
plt.savefig('large_hums.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)




