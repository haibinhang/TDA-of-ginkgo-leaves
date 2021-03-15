# TDA-of-ginkgo-leaves
Matlab functions designed for topological data analysis of ginkgo leaf image data

## Overview
This repo contains a bunch of matlab functions we wrote for topological data analysis of ginkgo leaves. All the matlab functions we wrote can be found in folder "my_functions_matlab". In folder "leaf_images", we provided several example images you can play with using our code. Several basic demos which uses these functions are also provided as follows.

### Ginkgo leaf barcode computation
In "ginkgo_leaf_barcode.m" we show how to process an image of ginkgo leaf and produce its (0-th) persistence barcode.
The process includes: 1) segment a leaf image; 2) cut off stem from leaf; 3) find the contour curve of leaf; 4) calculate the length of the stem; 5) reparametrize the contour ploygon curve; 6) build filtered simplicial complex and calculate the persistent homology of it (using JavaPlex); 7) plot the persistence barcode. 
### Multi dimensional scalling for a set of leaf images
In "multi_dimensional_scalling.m" we show how to do multi-dimensional scalling analysis on a set of ginkgo leaves: 1) construct a distance matrix based on a distance we defined beween two persistence barcodes of two ginkgo leaves; 2) apply multi-dimensional scalling on the distance matrix to find out the principle components of leaf data set; 3) project the leave data set on a 2-D plane in which x-axis and y-axis representing the first two principle components. This 2-D plot would show the main shape variations detected using topological data analysis.

At the end of this file, we also shows how to calculate the area of each leaf using a build in matlab function.

## Note
Please make sure you installed and ran JavaPlex for matlab before you run the examples we provided. A tutorial about javaplex in matlab can be found here (you may only need to read section 1.3 for installation):
https://www.math.colostate.edu/~adams/research/javaplex_tutorial.pdf

