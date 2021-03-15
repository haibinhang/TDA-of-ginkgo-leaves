# TDA-of-ginkgo-leaves
Matlab functions designed for topological data analysis of ginkgo leaf image data

## Overview
This repo contains matlab functions we wrote for topological data analysis of ginkgo leaves. All the matlab functions we wrote can be found in folder "my_functions_matlab". In folder "leaf_images", we provide several example images you can use to test our code. Several basic demos which use these functions are also provided as follows.

### Ginkgo leaf barcode computation
In "ginkgo_leaf_barcode.m" we show how to process a ginkgo leaf image and produce its (0-th) persistence barcode.
The process includes: 1) segmentation a leaf image; 2) cutting off the petiole; 3) finding the contour curve; 4) calculating the length of the petiole; 5) reparametrizing the contour curve; 6) building filtered simplicial complexes and calculating the persistent homology (using JavaPlex); 7) plotting the persistence barcode.

### Multi dimensional scalling for a set of leaf images
In "multi_dimensional_scalling.m" we show how to do multi-dimensional scalling analysis on a set of ginkgo leaves: 1) construct a distance matrix based on a distance beween two persistence barcodes of ginkgo leaves; 2) apply multi-dimensional scalling on the distance matrix to find and visualize the dominant modes of shape variation; 3) project the leave data set onto a 2-D plane in which x-axis and y-axis representing the first two main modes.

At the end of this file, we also show how to calculate the area of each leaf using a build-in matlab function.

## Note
Please make sure you installed and ran JavaPlex for matlab before you run the examples we provided. A tutorial about javaplex in matlab can be found here (you may only need to read section 1.3 for installation):
https://www.math.colostate.edu/~adams/research/javaplex_tutorial.pdf

