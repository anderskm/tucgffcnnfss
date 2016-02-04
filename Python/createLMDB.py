#!/usr/bin/python

# Author: 	Anders Krogh Mortensen
# Affilication: Dept. of Agroecology, Aarhus University
# Date: 	4 Feb. 2016
# 
# Originally created by user mhsung at Github (see https://gist.github.com/shelhamer/80667189b218ad570e82#gistcomment-1672427). Modified by Anders.

import caffe
import glob
import lmdb
import numpy as np
from PIL import Image
import os
import sys

# Paths
# Input images images
color_dir = './pascal/VOC2010/JPEGImages'
# Label images
# Per-pixel labels are stored in a gray image
label_dir = './pascal/VOC2010/59_context_labels (test)'
# Output directory
output_dir = './lmdb/test/'


#inputs = glob.glob(color_dir + '/*.png')
inputs = glob.glob(color_dir + '/*.jpg')

color_lmdb_name = output_dir + '/color-lmdb'
if not os.path.isdir(color_lmdb_name):
    os.makedirs(color_lmdb_name)
color_in_db = lmdb.open(color_lmdb_name, map_size=int(1e12))

label_lmdb_name = output_dir + '/label-lmdb'
if not os.path.isdir(label_lmdb_name):
    os.makedirs(label_lmdb_name)
label_in_db = lmdb.open(label_lmdb_name, map_size=int(1e12))

num_images = 0;
color_mean_color = np.zeros((3))

skipped_images = 0;

with color_in_db.begin(write=True) as color_in_txn:
    with label_in_db.begin(write=True) as label_in_txn:

        for in_idx, in_ in enumerate(inputs):
            img_name = os.path.splitext( os.path.basename(in_))[0]
            color_filename = color_dir + '/' + img_name + '.jpg'
            label_filename = label_dir +'/' + img_name + '.png'
            print(str(in_idx + 1) + ' / ' + str(len(inputs)))

            if (os.path.isfile(label_filename)):

                # load image
                imData = np.array(Image.open(color_filename)) # or load whatever ndarray you need
                assert imData.dtype == np.uint8            
                # RGB to BGR
                imData = imData[:,:,::-1]
                # in Channel x Height x Width order (switch from H x W x C)
                imData = imData.transpose((2,0,1))

                # compute mean color image
                for i in range(3):
                    color_mean_color[i] += imData[i,:,:].mean()
                num_images += 1

                #color_im_dat = caffe.io.array_to_datum(im)
                datumData = caffe.proto.caffe_pb2.Datum()
                datumData.channels, datumData.height, datumData.width = imData.shape
#                assert datumData.height == img_height
#                assert datumData.width == img_width

                imLabel = np.array(Image.open(label_filename)) # or load whatever ndarray you need
                assert imLabel.dtype == np.uint8
                datumLabel = caffe.proto.caffe_pb2.Datum()
                datumLabel.channels = 1
                datumLabel.height, datumLabel.width = imLabel.shape
#                assert label_im_dat.height == img_height
#                assert label_im_dat.width == img_width
                if (datumData.width == datumLabel.width):
                    if (datumData.height == datumLabel.height):
                        datumData.data = imData.tostring()
                        color_in_txn.put('{:0>12d}'.format(in_idx), datumData.SerializeToString())
                        datumLabel.data = imLabel.tostring()
                        label_in_txn.put('{:0>12d}'.format(in_idx), datumLabel.SerializeToString())
                    else:
                        skipped_images += 1
                else:
                    skipped_images += 1
            else:
                skipped_images += 1
    label_in_db.close()
color_in_db.close()

print(' ');
print('Processed images: ' + str(len(inputs)-skipped_images));
print('Skipped images: ' + str(skipped_images));
print('Total images: ' + str(len(inputs)));
print(' ');

color_mean_color /= num_images
np.savetxt(output_dir + '/{}.csv'.format('color-mean'), color_mean_color, delimiter=",", fmt='%.4f')

print(' ');
print('Mean colors (BGR): ' + str(color_mean_color));
print('csv-file with mean color values saved in ' + output_dir);
print(' ');
