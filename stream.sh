#!/bin/bash
# /usr/bin/ffmpeg -rtsp_transport tcp -i rtsp://192.168.200.137:14554/live/av0 -c:v copy -c:a aac -strict -2 -flags -global_header -hls_time 2 -hls_list_size 5  $PWD/public_html/stream_14/room.m3u8 & /
# /usr/bin/ffmpeg -rtsp_transport tcp -i rtsp://192.168.200.111:1554/live/av0 -c:v copy -c:a aac -strict -2 -flags -global_header -hls_time 2 -hls_list_size 5  $PWD/public_html/stream_1/room.m3u8

declare -a rtspLists
rtspLists=(
    [1]='rtsp://192.168.200.111'
    [2]='rtsp://192.168.200.113'
    [3]='rtsp://192.168.200.115'
    [4]='rtsp://192.168.200.117'
    [5]='rtsp://192.168.200.119'
    [6]='rtsp://192.168.200.121'
    [7]='rtsp://192.168.200.123'
    [8]='rtsp://192.168.200.125'
    [9]='rtsp://192.168.200.127'
    [10]='rtsp://192.168.200.129'
    [11]='rtsp://192.168.200.131'
    [12]='rtsp://192.168.200.133'
    [13]='rtsp://192.168.200.135'
    [14]='rtsp://192.168.200.137'
)

# for ((i=1; i<=14; i++))
for i in "${!rtspLists[@]}"
do
    # echo $i
    # echo $i
    # echo ${rtspLists[$i]}
    NAME_DIR="$PWD/public_html/stream_$i"

    if [[ ! -e $NAME_DIR ]]; then
        mkdir $NAME_DIR
    elif [[ ! -d $NAME_DIR ]]; then
        echo "$NAME_DIR already exists but is not a directory" 1>&2
    fi

    if [[ -d $NAME_DIR ]]; then
        URL_STREAM="$PWD/public_html/stream_${i}/room.m3u8"
        URL_STREAM_ALL="$PWD/public_html/stream_${i}/*"
        #if [[ -f "$URL_STREAM_ALL" ]]; then
        rm -rf $URL_STREAM_ALL
        #fi
        RTSP_CAMERA="${rtspLists[$i]}:${i}554/live/av0"
        echo $RTSP_CAMERA
        #echo $URL_STREAM
        FFMPEG=`which ffmpeg`
        #echo $FFMPEG
        $FFMPEG -rtsp_transport tcp -i $RTSP_CAMERA -c:v copy -c:a aac -strict -2 -flags -global_header -hls_time 2 -hls_list_size 5 $URL_STREAM &
    fi
done