<!-- README.md is generated from README.Rmd. Please edit that file -->
Hydroplots
==========

hydroplots currently includes a single function to plot a raster heat map of flow and cease to flow spells (or spells below a threshold) based on daily time-series data. An example plot is shown below for Cooper Creek. The function uses geom\_raster() from the ggplot2 package.

![Alt tag](https://github.com/nickbond/hydroplots/ctf_heatmap.png "CTF Heatmap")

Installation
============

To install run the following code:

    install.packages(c("devtools"))

    #install pacakge
    devtools::install_github("nickbond/hydroplots")

    # Remove the package zip after installation
    unlink("hydroplots.zip")

Developer
=========

Nick Bond <n.bond@griffith.edu.au>
