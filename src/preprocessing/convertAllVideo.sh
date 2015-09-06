#!/bin/bash

in_dir="$HOME/loop_exp/data/original/"
out_dir="$HOME/loop_exp/data/small/"

for video in `ls ${in_dir}*.mp4`
do
  file=${video##*/}
  ./convertVideoSize.sh ${in_dir}${file} 240 ${out_dir}${file}
done
