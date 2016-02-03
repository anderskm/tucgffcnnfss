# The unofficial Caffe guide for "Fully Convolutional Network for Semantic Segmentaiton"
This git serves as a guide for installing and running [Fully Convolutional Networks for Semantic Segmentation](http://www.cs.berkeley.edu/~jonlong/long_shelhamer_fcn.pdf "Fully Convolutional Networks for Semantic Segmentation") in [Caffe](http://caffe.berkeleyvision.org/ "Caffe"). This git is NOT a repository for Caffe, Caffe models or datasets, however, links to official repositories and webpages will be provided where relevant.
Scripts and code helpful to data conversion between MATLAB, images and Caffe are provided.

# Links
- Caffe: [http://caffe.berkeleyvision.org/](http://caffe.berkeleyvision.org/)
- Research paper: [http://www.cs.berkeley.edu/~jonlong/long_shelhamer_fcn.pdf](http://www.cs.berkeley.edu/~jonlong/long_shelhamer_fcn.pdf)
- Models in Caffe Model-Zoo: [https://github.com/BVLC/caffe/wiki/Model-Zoo#fcn](https://github.com/BVLC/caffe/wiki/Model-Zoo#fcn)
- Caffe future branch: [https://github.com/longjon/caffe/tree/future](https://github.com/longjon/caffe/tree/future)
- PASCAL VOC 2010: [http://host.robots.ox.ac.uk/pascal/VOC/voc2010/](http://host.robots.ox.ac.uk/pascal/VOC/voc2010/)
- PASCAL-context: [http://www.cs.stanford.edu/~roozbeh/pascal-context/](http://www.cs.stanford.edu/~roozbeh/pascal-context/)

# Disclaimer
The author of this guide share no connection to Caffe, PASCAL or the authors of “Fully Convolutional Network for Semantic Segmentation”. All credit for the 

----------

# Installing Caffe future branch
To evaluate and train fully convolutional networks for semantic segmentation, Caffe Future branch must be installed rather than the main Caffe branch. This guide will explain how to install the Caffe future branch rather than the main branch. All of the steps during installation are the same with the exception of cloning git repository.

## Guide
1. If you already have Caffe installed, delete or rename the folder called ~/code (which should contain you Caffe installation).
2. Follow [this guide](https://github.com/tiangolo/caffe/blob/ubuntu-tutorial-b/docs/install_apt2.md) for Installation and setup of Caffe, BUT…
  1. When cloning Caffe, in the step [Configure and Compile Caffe](https://github.com/tiangolo/caffe/blob/ubuntu-tutorial-b/docs/install_apt2.md#configure-and-compile-caffe), use the path for the Future branch instead:
```
	git clone https://github.com/longjon/caffe.git
```

----------

# Evaluate PASCAL-Context images on FCN-32s

## Guide
1. Download the Caffe network definitions from github
  1. Go to [https://gist.github.com/shelhamer/80667189b218ad570e82#file-readme-md](https://gist.github.com/shelhamer/80667189b218ad570e82#file-readme-md)
  1. Select “Download ZIP”
  1. In the File Explorer in Ubutuntu, go to ~/code/caffe/models and create a folder called fcn_32_pascal_contex
  1. Extract the content of the ZIP to this folder
1. Download the pre-trained model
  1. Download link: [http://dl.caffe.berkeleyvision.org/fcn-32s-pascalcontext.caffemodel](http://dl.caffe.berkeleyvision.org/fcn-32s-pascalcontext.caffemodel)
  1. Place file in ~/code/caffe/models/fcn_32_pascal_contex
1. Download the VOC2010 dataset
  1. Download the Training/Validation set from the Development Kit section of the Pascal VOC2010 webpage: [http://host.robots.ox.ac.uk/pascal/VOC/voc2010/#devkit](http://host.robots.ox.ac.uk/pascal/VOC/voc2010/#devkit)
  1. Unzip the content to ~/code/caffe/models/pascal/VOC2010/
   1. **Note:** The VOC2010 folder should contain 5 folders named “Annotations”, “ImageSets”, “JPEGImages”, “SegmentationClass” and “SegmentationObject”. However, in this guide we will only be using the JPEGImages folder.
1. Download the class labels
  1. Download link: [http://www.cs.stanford.edu/~roozbeh/pascal-context/59_labels.txt](http://www.cs.stanford.edu/~roozbeh/pascal-context/59_labels.txt)
  1. **Note: **These are only needed for your own reference.
1. Modify eval.py to show the output from the network
  1. Open a Terminal window (Ctrl+alt+T)
  1. Go to the folder with the FCN32 model:
```
cd $CAFFE_ROOT/models/fcn_32_pascal_contex
```
  1. Open eval.py in gedit:
```
gedit eval.py
```
  1. In the top of the document add:
```python
from skimage import io
```
  1. In end of the document add:
```python
io.imshow(out)
io.show()
```
  1. Save and close the document.
1. Run the test example
  1. Open a Terminal window (Ctrl+Alt+T)
  1. Type ipython eval.py to run the test image through the network.
  1. When the image has been evaluated, the highest scoring class for each pixel will be displayed as an image.
  1. Place the mouse over a pixel to read its label ID and use the class labels from step 4 to translate it into a class.
  1. You should see something like left image below.


----------