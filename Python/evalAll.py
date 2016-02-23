import numpy as np
from PIL import Image
from skimage import io
import png
import os
import glob

import caffe

inputFolder = './Data/Color'
outputFolder =  './Data/Evaluated'
networkPrototext = 'deploy.prototxt'
modelFilename = 'trainFinetune_cigar_iter_2160.caffemodel'
imageMeans = (63.1183,100.9869,94.5597)

# Create output directory
if not os.path.isdir(outputFolder):
    os.makedirs(outputFolder)

# Find all jpg-files in input directory
inputs = glob.glob(inputFolder + '/*.JPG')

# Setup Caffe
caffe.set_mode_gpu()
caffe.set_device(3)

# load net
net = caffe.Net(networkPrototext, modelFilename, caffe.TEST)

# Loop through all images
for in_idx, in_ in enumerate(inputs):
    print(str(in_idx + 1) + ' / ' + str(len(inputs)))
    
    img_name = os.path.splitext( os.path.basename(in_))[0]
    color_filename = inputFolder + '/' + img_name + '.JPG'
    
    # load image
    imData = np.array(Image.open(color_filename))
    imData = np.array(imData, dtype=np.float32)
    imData = imData[:,:,::-1]
    imData -= np.array(imageMeans)
    imData = imData.transpose((2,0,1))
    
    # shape for input (data blob is N x C x H x W), set data
    net.blobs['data'].reshape(1, *imData.shape)
    net.blobs['data'].data[...] = imData
    
    # run net and take argmax for prediction
    net.forward()
    out = net.blobs['score'].data[0].argmax(axis=0)
    H,W = out.shape
    
    # Save results
    eval_filename = outputFolder + '/' + img_name + '.png'
    f = open(eval_filename,'wb')
    w = png.Writer(width=W,height=H,greyscale=True,bitdepth=8)
    w.write(f, out)
    f.close()

