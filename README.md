<!-- README.md is generated from README.Rmd. Please edit that file -->
Hydroplots
==========

hydroplots currently includes a single function (ctf\_heatmap) to plot a raster heat map of flow and cease to flow spells (or spells below a threshold) based on daily time-series data.

Example
=======

The code below produces the following plot for Cooper Creek, a highly ephemeral river in western Queensland, Australia. The function uses geom\_raster() from the ggplot2 package. Addtional options are available (see ?ctf\_raster for details).

     library(hydrostats)
     data(Cooper)
     ctf_heatmap(Cooper)

![Alt tag](https://github.com/nickbond/hydroplots/raw/master/ctf_heatmap.png "CTF Heatmap")

Installation
============

To install run the following code:

      # install devtools pacakge
      install.packages(c("devtools"))

      # install hydroplots package
        devtools::install_github("nickbond/hydroplots")

        # Remove the package zip after installation
        unlink("hydroplots.zip")

Developer
=========

Nick Bond <n.bond@griffith.edu.au>
