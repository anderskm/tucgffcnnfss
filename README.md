# The unofficial Caffe guide for "Fully Convolutional Network for Semantic Segmentaiton"
This git serves as a guide for installing and running [Fully Convolutional Networks for Semantic Segmentation](http://www.cs.berkeley.edu/~jonlong/long_shelhamer_fcn.pdf "Fully Convolutional Networks for Semantic Segmentation") in [Caffe](http://caffe.berkeleyvision.org/ "Caffe"). This git is NOT a repository for Caffe, Caffe models or datasets, however, links to official repositories and webpages will be provided where relevant.
Scripts and code helpful to data conversion between MATLAB, images and Caffe are provided.

# Links
- Caffe: [http://caffe.berkeleyvision.org/](http://caffe.berkeleyvision.org/)
- Research paper: [http://www.cs.berkeley.edu/~jonlong/long_shelhamer_fcn.pdf](http://www.cs.berkeley.edu/~jonlong/long_shelhamer_fcn.pdf)
- Models in Caffe Model-Zoo: [https://github.com/BVLC/caffe/wiki/Model-Zoo#fcn](https://github.com/BVLC/caffe/wiki/Model-Zoo#fcn)
- Caffe future branch: [https://github.com/longjon/caffe/tree/future](https://github.com/longjon/caffe/tree/future)
- PASCAL VOC 2010: [http://host.robots.ox.ac.uk/pascal/VOC/voc2010/](http://host.robots.ox.ac.uk/pascal/VOC/voc2010/)
- PASCALl-context: [http://www.cs.stanford.edu/~roozbeh/pascal-context/](http://www.cs.stanford.edu/~roozbeh/pascal-context/)

# Disclaimer
The author of this guide share no connection to Caffe, PASCAL or the authors of “Fully Convolutional Network for Semantic Segmentation”. All credit for the 

----------

# Installing Caffe future branch
Evaluate and train fully convolutional networks for semantic segmentation Caffe Future branch must be installed rather than the main Caffe branch.

## Guide
1. If you already have Caffe installed, delete or rename the folder called ~/code (which would contain you Caffe installation if you followed the earlier guide).
2. Follow [this guide](https://github.com/tiangolo/caffe/blob/ubuntu-tutorial-b/docs/install_apt2.md) for Installation and setup of Caffe, BUT…
  1. In the step [Configure and Compile Caffe](https://github.com/tiangolo/caffe/blob/ubuntu-tutorial-b/docs/install_apt2.md#configure-and-compile-caffe) use the use:

  ```
	git clone https://github.com/longjon/caffe.git
  ```
  instead of
  ```
	git clone https://github.com/BVLC/caffe.git
  ```

----------
 