python

import numpy as np;
import matplotlib.pyplot as plt;

A=1;
B=1;
C=0;
D=0;
dt=0.1;

t=np.arange(-np.pi, np.pi, dt);

y=A*np.sin(B*t+C)+D;

plt.figure(1);
plt.grid(True);
plt.plot(t,y,'r_');
plt.show()

A=3;
y=A*np.sin(B*t+C)+D;

plt.figure(1);
plt.grid(True);
plt.plot(t,y,'r_');
plt.show()

A=1;
B=.5;
y=A*np.sin(B*t+C)+D;
plt.figure(1);
plt.grid(True);
plt.plot(t,y,'r_');
plt.show()

B=1;
C=-np.pi/2;
y=A*np.sin(B*t+C)+D;
plt.figure(1);
plt.grid(True);
plt.plot(t,y,'r_');
plt.show()

C=0;
D=4;
y=A*np.sin(B*t+C)+D;
plt.figure(1);
plt.grid(True);
plt.plot(t,y,'r_');
plt.show()

dx=.1;
x=np.arange(0, 2, dx);
A=1/2;
B=-1/2;
e=np.e;
y=A*e**x+B*e**-x;
plt.figure(1);
plt.grid(True);
plt.plot(x,y);
plt.show()

dx=.1;
x=np.arange(0, 2, dx);
A=-1;
B=1;
e=np.e;
y=A*e**x+B*e**-x;
plt.figure(1);
plt.grid(True);
plt.plot(x,y);
plt.show()

dx=.1;
x=np.arange(0, 2, dx);
e=np.e;
y=e**x;
plt.figure(1);
plt.grid(True);
plt.plot(x,y);
plt.show()

dx=.1;
x=np.arange(0, 2, dx);
y=2**x;
plt.figure(1);
plt.grid(True);
plt.plot(x,y);
plt.show()

dx=.1;
x=np.arange(0, 2, dx);
y=3**x;
plt.figure(1);
plt.grid(True);
plt.plot(x,y);
plt.show()

dx=.1;
x=np.arange(0, 2, dx);
y=4**x;
plt.figure(1);
plt.grid(True);
plt.plot(x,y);
plt.show()




