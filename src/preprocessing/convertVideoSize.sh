#!/bin/bash

if [ $# != 2 -a $# != 3 ];then
  echo "$0 input_video_path(.mp4 only) cvtsize [output_video_path]"
  exit
fi
input=$1
toSize=$2
output=${input%.mp4}"_$toSize.mp4"
if [ $# == 3 ]; then
  output=$3
fi
ffmpeg -i $input -s ${toSize}x${toSize} $output
