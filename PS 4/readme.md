Solutions in PDF

**Problem1_PTSH_SDF.ipynb** has my code for the Problem 1 (Tuning Curves)

**mycode.m** has my code for Problem 2 (STRF and Spike Triggered Averaging). There is a deliberate repetion of code in plots so run whatever plot you want to generate. Run generateStimulus.m and generateKernel.m before running mycode.m

Plots displayed below. Search 4b to jump to plots of Spike Triggered Averaging problem 

## 4a Tuning Curves for neuron in visual cortex

six.mat is the file with just data from orientation 6 \
The frequency (ie. Y axis) labels may be incorrect for a few graphs as I was not able to resolve the issue. Happy to receive feedback for it !

### Raster Plot for Orientation 6
<img src="./a/raster plot stimulus 6.jpg" alt="./a/raster plot stimulus 6.jpg" width=500>

### Peri-stimulus time histogram (PSTH) for Orientation 6
<img src="./a/PTSH.png" alt="./a/PTSH.png" width=500>

### Convolution of Spike Train with Box Car Kernel for Orientation 6
<img src="./a/conv.png" alt="./a/conv.png" width=500>

### Convolution of Spike Train with Gaussian for Orientation 6
<img src="./a/gauss.png" alt="./a/gauss.png" width=500>

### Spike Density Function for Orientation 6
<img src="./a/sdf.png" alt="./a/sdf.png" width=500>

### Tuning Curve for neuron
<img src="./a/tuning.png" alt="./a/tuning.png" width=500>

### Adjusted Tuning Curve for neuron with no-stimulus firing rate removed
<img src="./a/adjtuning.png" alt="./a/adjtuning.png" width=500>

## 4b Spike Triggered Averaging to estimate auditory Spatio-temporal Receptive field

### Kernel (This code is provided by MIT)
<img src="./b/kernel.jpg" alt="./b/kernel.jpg" width=500>

### Stimuli, Excitatory Drive to neuron, Spiking
<img src="./b/plot2.jpg" alt="./b/plot2.jpg" width=500>

### Spike Triggered Average (150 ms before Spike)
<img src="./b/sta.jpg" alt="./b/sta.jpg" width=500>

### Spike Triggered Average (at Spike)
<img src="./b/atspike.jpg" alt="./b/atspike.jpg" width=500>

The kernel had 0 contribution in the middle frequencies but the STA has still counted them
during calculation. Although the STA plot shows low activity in these frequencies, a better
representative would be if random activity still occurred in these frequencies yet there was
a definite pattern of spiking. At the spikes, the STA shows high activity towrds the higher
frequency and low activity in the lower frequency. But the kernel had both positive and
negative contributions in the top and bottom in equal values. So STA would suggest that
top has mainly positive contribution and bottom has mainly negative contribution which is
not what the Kernel is.

### Spike Triggered Average (100 ms before Spike as kernel is 100 ms long)
<img src="./b/spike100.jpg" alt="./b/aspike100.jpg" width=500>

### Spike Triggered Average (150 ms - 100 ms before Spike) 
To see issues caused by difference in STA width and kernel width

<img src="./b/spike150100.jpg" alt="./b/aspike150100.jpg" width=500>
