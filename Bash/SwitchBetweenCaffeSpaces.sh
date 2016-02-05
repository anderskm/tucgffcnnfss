#!/bin/bash

# Run with ". SwitchBetweenCaffeSpaces.sh"
SOURCE1="/home/repete/DeepLearningStuff/caffe"
SOURCE2="/home/repete/DeepLearningStuff/caffeSS"
if [ "$CAFFE_ROOT" == "$SOURCE1" ]; then 
	export CAFFE_ROOT="$SOURCE2"
	TMP="Change to Source2";
#	echo  "$CAFFE_ROOT"
else
	
	export CAFFE_ROOT="$SOURCE1"
	TMP="Change to Source1";
#	echo "Change to Source2" "$CAFFE_ROOT"
fi

echo "$TMP" : "$CAFFE_ROOT"
export PYTHONPATH=$CAFFE_ROOT/python:$PYTHONPATH

#echo $CAFFE_ROOT
#echo $PYTHONPATH
