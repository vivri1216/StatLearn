import matplotlib.pyplot as plt
import numpy as np


# Data
num = [50, 500, 1000]
categories = ['$\pi = 0.1$', '$\pi = 0.5$', '$\pi = 0.7$']
values = np.array([[0.862, 0.954, 0.957], [0.923, 0.962, 0.947], [0.933, 0.952, 0.95]])

# Create horizontal bar plot
fig, ax = plt.subplots()
bar_width = 0.2
index = np.arange(len(categories))

# Grayscale colors for the bins
colors = ['#648fff', '#dc267f', '#ffb000']

# Plot each bin
for i in range(values.shape[1]):
    bars = ax.barh(index + i * bar_width, values[:, i], bar_width, label=num[i], color=colors[i])
    # Add value labels on the bars
    for bar in bars:
        ax.text(bar.get_width() + 0.07, bar.get_y() + bar.get_height() / 2, f'{bar.get_width()}', 
                va='center', ha='right', color='black', fontsize=8)
        
# Adjust y-ticks to be in the center of the grouped bars
ax.set_yticks(index + bar_width)
ax.set_yticklabels(categories)

# Remove x-axis label and values
ax.set_xlabel('')
ax.set_xticks([])

# Remove plot title
ax.set_title('')

# Remove the box (spines) around the plot
ax.spines['top'].set_visible(False)
ax.spines['right'].set_visible(False)
ax.spines['bottom'].set_visible(False)
ax.spines['left'].set_visible(False)

ax.legend()

# Show plot
plt.show()