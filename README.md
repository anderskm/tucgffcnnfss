# The unofficial Caffe guide for "Fully Convolutional Network for Semantic Segmentaiton"
This git serves as a guide for installing and running [Fully Convolutional Networks for Semantic Segmentation](http://www.cs.berkeley.edu/~jonlong/long_shelhamer_fcn.pdf "Fully Convolutional Networks for Semantic Segmentation") in [Caffe](http://caffe.berkeleyvision.org/ "Caffe"). This git is NOT a repository for Caffe, Caffe models or datasets, however, links to official repositories and webpages will be provided where relevant.
Scripts and code helpful to data conversion between MATLAB, images and Caffe are provided.
The guides assumes access to both python and MATLAB.

## Important note
Since the release of this unofficial guide, the authors of [Fully Convolutional Networks for Semantic Segmentation](http://www.cs.berkeley.edu/~jonlong/long_shelhamer_fcn.pdf "Fully Convolutional Networks for Semantic Segmentation") have launched their own [Github repository](https://github.com/shelhamer/fcn.berkeleyvision.org). Please visit [their repository](https://github.com/shelhamer/fcn.berkeleyvision.org), as it contains valuable information not covered here.

----------

# Guides:
The guides follows a sequential structure, where each guide assumes, that the previous guides have been completed.

1. [Installing Caffe future branch](Guides/01InstallingCaffeFutureBranch.md)
1. [Evaluate PASCAL-Context images on FCN-32s](Guides/02EvaluatePascalContextImagesOnFCN32s.md)
1. [Fine-tuning on PASCAL-context dataset](Guides/03FineTuneOnPascalContextDataset.md)
  * *Work in progress*
1. [Fine-tuning FCN-32s on own dataset](Guides/04FineTuneOnOwnDataset.md)
  * *Work in progress*

----------

# Links
- Caffe: [http://caffe.berkeleyvision.org/](http://caffe.berkeleyvision.org/)
- Research paper: [http://www.cs.berkeley.edu/~jonlong/long_shelhamer_fcn.pdf](http://www.cs.berkeley.edu/~jonlong/long_shelhamer_fcn.pdf)
- Models in Caffe Model-Zoo: [https://github.com/BVLC/caffe/wiki/Model-Zoo#fcn](https://github.com/BVLC/caffe/wiki/Model-Zoo#fcn)
- Caffe future branch: [https://github.com/longjon/caffe/tree/future](https://github.com/longjon/caffe/tree/future)
- PASCAL VOC 2010: [http://host.robots.ox.ac.uk/pascal/VOC/voc2010/](http://host.robots.ox.ac.uk/pascal/VOC/voc2010/)
- PASCAL-context: [http://www.cs.stanford.edu/~roozbeh/pascal-context/](http://www.cs.stanford.edu/~roozbeh/pascal-context/)

----------

# Disclaimer
The authors of this guide share no connection to Caffe, PASCAL or the authors of “Fully Convolutional Network for Semantic Segmentation”. All credit for developing the Caffe, gathering the PASCAL dataset and developing the method for "Fully Convolutional Network for Semantic Segmentation" should go to the respective authors, and not the authors of this guide.
