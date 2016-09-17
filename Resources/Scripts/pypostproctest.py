import matplotlib.pyplot as plt
import numpy as np
import DyMat

d = DyMat.DyMatFile('../PVArrayValidation.mat')
v = d['rampVoltage.v']
i = d['rampVoltage.i']
p = v*i

idxmp = np.argmax(p)
# print 'idxmp is %s' % type(idxmp)
# print 'v is %s' % type(v[0])
# print 'i is %s'  % type(i[0])
# print 'p is %s' % type(p[0])
print 'Max power at ({:.2f},{:.2f})'.format(v[idxmp], p[idxmp])

plt.figure(1)

plt.subplot(211)
plt.plot(v,i)
plt.plot(v[0],i[0],'ro')
plt.text(v[0],i[0],
  '({:.2f},{:.2f})'.format(v[0],i[0]))
plt.plot(v[-1],i[-1],'ro')
plt.text(v[-1],i[-1],
  '({:.2f},{:.2f})'.format(v[-1],i[-1]))
plt.xlabel('Voltage (V)')
plt.ylabel('Current (A)')
plt.grid(True)

plt.subplot(212)
plt.plot(v,p)
plt.plot(v[idxmp], p[idxmp],'ro')
plt.text(v[idxmp],p[idxmp]+5,
  '({:.2f},{:.2f})'.format(v[idxmp], p[idxmp]),
  horizontalalignment='center')
plt.xlabel('Voltage (V)')
plt.ylabel('Power (W)')
plt.grid(True)

plt.show()
