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
  
####################################################################################
##################################### NO MICROTOPO #################################
####################################################################################    

####################################################################################
####################### H / 25 peat / 75 sand / No hummocks  #######################
####################################################################################
# Sequential Indicator Simulation with Simple Kriging Multiple Realizations 
# A: 0.7512 / 0.2488 = SAND / PEAT
# B: 0.7464 / 0.25360000000000005
# C: 0.7524 / 0.2477
# D: 0.7422 / 0.2578    
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

        
sim25flat_exA = expand(sim25flatA,4)
sim25flat_exB = expand(sim25flatB,4)
sim25flat_exC = expand(sim25flatC,4)
sim25flat_exD = expand(sim25flatD,4)

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

####################################################################################
####################### H / 50 peat / 50 sand / No hummocks  #######################
####################################################################################

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

# 64519     

# Expand the simulation by a factor of 4
sim50flat_exA = expand(sim50flatA,4)
sim50flat_exB = expand(sim50flatB,4)
sim50flat_exC = expand(sim50flatC,4)


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

