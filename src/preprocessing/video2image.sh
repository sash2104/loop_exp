#!/bin/bash
# .mp4の動画をframeに分割し.pngで保存

if [ $# != 1 ];then
    echo $0 hoge.mp4
    exit
fi
input=$1
dir=${input%.mp4}"/"
if [ ! -d $dir ]; then
    mkdir $dir
fi
ffmpeg -i $input -f image2 -vcodec png ${dir}%d.png


