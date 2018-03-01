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


