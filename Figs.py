# Import Libraries
import os                                                 
import numpy as np                                      
import matplotlib.pyplot as plt     

# Go to directory for figures 
os.chdir("C:/Users/erikai94/Documents/UMass/Thesis/Figures")  

# Variogram
plt.figure(figsize=(6,4))  
x2  = np.arange(10,36, 1)
y2=np.repeat(1, 26)
x1  = np.arange(0,11, 1)
y1=1*(1.5*(x1/10)-0.5*((x1/10)**3))
x_range=np.repeat(10,2)
y_range=(0,1)
x_sill=(0,36)
y_sill=np.repeat(1,2)
plt.plot(x1,y1,color = 'black')
plt.plot(x2,y2,color = 'black')
plt.plot(x_range, y_range, color= 'black', ls='--')
plt.plot(x_sill, y_sill, color= 'black', ls='--')
plt.ylim([0,1.1])
plt.xlim([0,35])
plt.xticks(np.arange(0, 100,100 ))
plt.savefig('Sph_Vario.png', dpi=300)

# Monte Carlo Example
plt.figure(figsize=(6,4))  
x=(1,1)
y=(0,0.25)
x2=(1,2)
y2=(0.25,0.25)
x3=(2,2)
y3=(0.25,1)
plt.plot(x,y,color = 'black')
plt.plot(x2,y2,color = 'black')
plt.plot(x3,y3,color = 'black')
plt.ylim([0,1])
plt.xticks(np.arange(1,3,1))
plt.savefig('Monte_Carlo.png', dpi=300)
