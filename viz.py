from sys import argv
import matplotlib
matplotlib.use('Agg') 
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.ticker import AutoMinorLocator

arglen = len(argv)

avg = float(argv[1])

# set up the figure
fig = plt.figure()
ax = fig.add_subplot(111)
ax.set_xlim(3.075,3.2)
ax.set_ylim(0,10)
frameon=False
## Set x ticks
plt.xticks(np.linspace(3.075,3.2,5,endpoint=True))


# draw lines
xmin = 3
xmax = 3.5
yval = .3
height = 1
# ax.annotate('pi', xy=(np.pi,yval + 0.5), xycoords='data',
#             horizontalalignment='center', verticalalignment='center')
# ax.annotate('avg', xy=(avg,yval + 0.5), xycoords='data',
#             horizontalalignment='center', verticalalignment='center')


plt.hlines(yval, xmin, xmax)
#plt.vlines(xmin, y - height / 2., y + height / 2.)
#plt.vlines(xmax, y - height / 2., y + height / 2.)




for arg in argv[2:]:
    with open(arg) as f:
        for line in f:
            temp = [line[:-2]]
            x = float(line)
            plt.plot(x, yval, 'go', ms = 6)


ax.annotate('pi', xy=(np.pi,yval + 0.5), xycoords='data',
            horizontalalignment='center', verticalalignment='center', color='y', size=8)
ax.annotate('avg', xy=(avg,yval + 0.5), xycoords='data',
            horizontalalignment='center', verticalalignment='bottom', color='r', size=8)
px = np.pi
plt.plot(px,yval, 'yo', ms = 8)
plt.plot(avg,yval, 'ro', ms = 6)

ax.xaxis.set_minor_locator(AutoMinorLocator(6))

#extraticks=[np.pi]
#plt.xticks(list(plt.xticks()[0]) + extraticks)
ax.yaxis.set_visible(False)
#ax.set_frame_on(False)

#labels = [item.get_text() for item in ax.get_xticklabels()]
#
#empty_string_labels = ['']*len(labels)
#ax.set_xticklabels(empty_string_labels)
# draw a point on the
if __name__ == '__main__':
    plt.savefig("hello.png")
