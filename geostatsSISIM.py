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


# Sequential Indicator Simulation with Simple Kriging Multiple Realizations 
nx = 1000; ny = 50; xsiz = 2.0; ysiz = 2.0; xmn = 1; ymn = 1; nxdis = 1; nydis = 1
ndmin = 0; ndmax = 10; nodmax = 10; radius = 100; skmean = 0
tmin = -999; tmax = 999
dummy_trend = np.zeros((10,10))            # the current version requires trend input - if wrong size it is ignored 

ncut = 2                                   # number of facies
thresh = [0,1]                             # the facies categories (use consisten order)
gcdf = [0.2,0.8]                           # the global proportions of the categories
varios = []                                # the variogram list
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=90,hmaj1=100,hmin1=30)) # shale indicator variogram
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=90,hmaj1=300,hmin1=30))#sand indicator variogram

sim_ik1 = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=2,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 73073,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

#sim_ik2 = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
#               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=2,
#               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 73074,
#               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

#sim_ik3 = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
#               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=2,
#               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 73075,
#               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

xmin = 0.0; xmax = 2000.0; ymin = 0.0; ymax = 100.0; cmap = plt.cm.get_cmap('Reds_r') # plotting parameters

plt.imshow(sim_ik1, cmap='Greys_r')

# Sequential Indicator Simulation with Simple Kriging Multiple Realizations 
nx = 200; ny = 10; xsiz =1; ysiz = 1; xmn = 0.5; ymn = 0.5; nxdis = 1; nydis = 1
ndmin = 0; ndmax = 10; nodmax = 10; radius =20; skmean = 0
tmin = -99; tmax = 99
dummy_trend = np.zeros((10,10))            # the current version requires trend input - if wrong size it is ignored 

ncut = 2                                   # number of facies
thresh = [0,1]                             # the facies categories (use consisten order)
gcdf = [0.2,0.8]                           # the global proportions of the categories
varios = []                                # the variogram list
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=90,hmaj1=10,hmin1=5)) # shale indicator variogram
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=90,hmaj1=10,hmin1=5))#sand indicator variogram

sim_ik1 = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 73071,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim_ik2 = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 73077,
 
              ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)
sim_ik3 = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 73069,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

plt.imshow(sim_ik3, cmap='Greys_r')
plt.imshow(sim_ik2, cmap='Greys_r')
plt.imshow(sim_ik1, cmap='Greys_r')



xmin = 0.0; xmax = 2000.0; ymin = 0.0; ymax = 100.0; cmap = plt.cm.get_cmap('Reds_r') # plotting parameters

plt.imshow(sim_ik1, cmap='Greys_r')

# Sequential Indicator Simulation with Simple Kriging Multiple Realizations 
nx = 1000; ny = 38; xsiz =1; ysiz = 1; xmn = 0.5; ymn = 0.5; nxdis = 1; nydis = 1
ndmin = 0; ndmax = 10; nodmax = 10; radius =40; skmean = 0
tmin = -999; tmax = 999
dummy_trend = np.zeros((10,10))            # the current version requires trend input - if wrong size it is ignored 

ncut = 2                                   # number of facies
thresh = [0,1]                             # the facies categories (use consisten order)
gcdf = [0.2,0.8]                           # the global proportions of the categories
varios = []                                # the variogram list
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=90,hmaj1=100,hmin1=25)) # shale indicator variogram
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=90,hmaj1=100,hmin1=25))#sand indicator variogram

sim_ik1 = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 73021,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim_ik2 = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 73021,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim_ik3 = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 73023,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

plt.imshow(sim_ik1, cmap='Greys_r')
plt.imshow(sim_ik2, cmap='Greys_r')
plt.imshow(sim_ik3, cmap='Greys_r')

plt.figure(figsize=(20,.37))                                    # plot the results
fig=plt.imshow(sim_ik1, cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
fig.axes.get_yaxis().set_visible(False)
plt.savefig('xyz.png', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Sequential Indicator Simulation with Simple Kriging Multiple Realizations 
nx = 1000; ny = 100; xsiz =1; ysiz = 1; xmn = 0.5; ymn = 0.5; nxdis = 1; nydis = 1
ndmin = 0; ndmax = 10; nodmax = 10; radius =40; skmean = 0
tmin = -999; tmax = 999
dummy_trend = np.zeros((10,10))            # the current version requires trend input - if wrong size it is ignored 

ncut = 2                                   # number of facies
thresh = [0,1]                             # the facies categories (use consisten order)
gcdf = [0.2,0.8]                           # the global proportions of the categories
varios = []                                # the variogram list
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=90,hmaj1=100,hmin1=30)) # shale indicator variogram
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=90,hmaj1=100,hmin1=30))#sand indicator variogram

sim_ik1 = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 73021,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim_ik2 = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 73011,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim_ik3 = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 73075,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim_ik4 = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 73045,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim_ik5 = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 73201,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim_ik6 = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 73203,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)


plt.imshow(sim_ik1, cmap='Greys_r')
plt.imshow(sim_ik2, cmap='Greys_r')
plt.figure(figsize=(20,1))                                    # plot the results
fig=plt.imshow(sim_ik2, cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
fig.axes.get_yaxis().set_visible(False)
plt.savefig('sp_xyz.pdf', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

# Good one!
plt.imshow(sim_ik5, cmap='Greys_r')

# Sequential Indicator Simulation with Simple Kriging Multiple Realizations 
nx = 500; ny = 25; xsiz =2; ysiz = 2; xmn = 1; ymn = 1; nxdis = 1; nydis = 1
ndmin = 0; ndmax = 10; nodmax = 10; radius =30; skmean = 0
tmin = -999; tmax = 999
dummy_trend = np.zeros((10,10))            # the current version requires trend input - if wrong size it is ignored 

ncut = 2                                   # number of facies
thresh = [0,1]                             # the facies categories (use consisten order)
gcdf = [0.2,0.8]                           # the global proportions of the categories
varios = []                                # the variogram list
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=90,hmaj1=25,hmin1=10)) # shale indicator variogram
varios.append(GSLIB.make_variogram(nug=0,nst=1,it1=1,cc1=1,azi1=90,hmaj1=25,hmin1=10))#sand indicator variogram

sim_ik1 = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 73073,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim_ik2 = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 73077,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

sim_ik3 = geostats.sisim(df,'X','Y','Facies',ivtype=0,koption=0,ncut=2,thresh=thresh,gcdf=gcdf,trend=dummy_trend,
               tmin=tmin,tmax=tmax,zmin=0.0,zmax=1.0,ltail=1,ltpar=1,middle=1,mpar=0,utail=1,utpar=1,
               nx=nx,xmn=xmn,xsiz=xsiz,ny=ny,ymn=ymn,ysiz=ysiz,seed = 73069,
               ndmin=ndmin,ndmax=ndmax,nodmax=nodmax,mults=1,nmult=3,noct=-1,radius=radius,ktype=0,vario=varios)

fig=plt.imshow(sim_ik1, cmap='Greys_r', )
# Good one!
plt.figure(figsize=(20,1))                                    # plot the results
fig=plt.imshow(sim_ik2, cmap='Greys_r')
plt.axis('off')
fig.axes.get_xaxis().set_visible(False)
fig.axes.get_yaxis().set_visible(False)
plt.savefig('sp_xyz.pdf', bbox_inches='tight', dpi=300, frameon='false', pad_inches=0)

plt.imshow(sim_ik3, cmap='Greys_r')






plt.plot()      
plt.figure(figsize=(20,1))                                    # plot the results
GSLIB.locpix_st(sim_ik1,xmin,xmax,ymin,ymax,xsiz,0,1.0,df,'X','Y','Facies','Sequential Indicator Simulation - Realization 1','X(m)','Y(m)','Facies',cmap)

plt.savefig('horiz_sim.png', dpi=600, bbox_inches = 'tight')

plt.plot()      
plt.figure(figsize=(20,1))                                    # plot the results
GSLIB.locpix_st(sim_ik1,xmin,xmax,ymin,ymax,xsiz,0.3,1.0,df,'X','Y','Facies','Sequential Indicator Simulation - Realization 1','X(m)','Y(m)','Facies',cmap)

plt.savefig('horiz_sim2.png', dpi=600, bbox_inches = 'tight', pad_inches=0)

plt.hist(sim_ik1.flatten(),bins=2,density=True,cumulative = True,alpha=0.1,color='red',edgecolor='black')

# Add hummocks


# Assign sine wave x values (1 per cm)
d  = np.arange(0, 100, 1)
# Define hummock height, and width (in cm)
hum_h=20
# Create sine wave for hummocky top surface 
top_surf  = hum_h*np.sin(0.02*np.pi*d)+38
# Plot a sine wave using time and amplitude obtained for the sine wave
plt.plot(d, top_surf)
# Give a title for the sine wave plot
#plot.title('Sine wave')
# Give x axis label for the sine wave plot
#plot.xlabel('Distance (cm)')
# Give y axis label for the sine wave plot
#plot.ylabel('Height (cm)')
#plot.grid(True, which='both')
#plot.axhline(y=0, color='k')
#plot.show()

def integrand(d):
    return hum_h*np.sin(0.02*np.pi*d)+38

integrate.quad(integrand, 0, 1000)

 

# Display the sine wave

plot.show()

