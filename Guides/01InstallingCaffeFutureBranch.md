# Installing Caffe future branch
To evaluate and train fully convolutional networks for semantic segmentation, Caffe Future branch must be installed rather than the main Caffe branch. This guide will explain how to install the Caffe future branch rather than the main branch. All of the steps during installation are the same with the exception of cloning git repository.

## Guide
1. If you already have Caffe installed, delete or rename the folder called ~/code (which should contain you Caffe installation).
2. Follow [this guide](https://github.com/tiangolo/caffe/blob/ubuntu-tutorial-b/docs/install_apt2.md) for Installation and setup of Caffe, BUT…
  1. When cloning Caffe, in the step [Configure and Compile Caffe](https://github.com/tiangolo/caffe/blob/ubuntu-tutorial-b/docs/install_apt2.md#configure-and-compile-caffe), use the path for the Future branch instead:
```
	git clone https://github.com/longjon/caffe.git
```
