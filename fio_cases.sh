#!/usr/bin/env bash

function runtime() { 
    rw=$1
    bs=$2
    mkdir -p logs/runtime.${rw}_${bs}
    sed -i "s/^rw=.*/rw=${rw}/" runtime.conf
    sed -i "s/^bs=.*/bs=${bs}/" runtime.conf

    echo ${rw}_${bs}
    echo -e runtime"\t"iops"\t""bw(Mib/s)""\t""clat(usec)"

    for runtime in 30 60 90 120 150 180;
    do
        sed -i "/^runtime/c runtime=${runtime}" runtime.conf;
        fio runtime.conf > logs/runtime.${rw}_${bs}/${runtime}.log 2>&1; 
        result=$(sh ./fio_result.sh logs/runtime.${rw}_${bs}/${runtime}.log);
        echo -e $runtime'\t'$result;
    done
}

function blocksize() { 
    rw=$1
    mkdir -p logs/blocksize.${rw}
    sed -i "s/^rw=.*/rw=${rw}/" blocksize.conf

    echo ${rw}
    echo -e blocksize"\t"iops"\t""bw(Mib/s)""\t""clat(usec)"

    for bs in 4k 8k 16k 32k 64k 128k 256k 512k 1m 2m 4m 8m 16m;
    do
        sed -i "/^bs=/c bs=${bs}" blocksize.conf;
        fio blocksize.conf > logs/blocksize.${rw}/${bs}.log 2>&1; 
        result=$(sh ./fio_result.sh logs/blocksize.${rw}/${bs}.log);
        echo -e $bs'\t'$result;
    done
}

function numjobs() { 
    rw=$1
    bs=$2
    mkdir -p logs/numjobs.${rw}_${bs}
    sed -i "s/^rw=.*/rw=${rw}/" numjobs.conf
    sed -i "s/^bs=.*/bs=${bs}/" numjobs.conf

    echo ${rw}_${bs}
    echo -e numjobs"\t"iops"\t""bw(Mib/s)""\t""clat(usec)"

    for numjobs in 1 2 4 8 16 32 50 60 70 80 90 100 110 120;
    do
        sed -i "/^numjobs/c numjobs=${numjobs}" numjobs.conf;
        fio numjobs.conf > logs/numjobs.${rw}_${bs}/${numjobs}.log 2>&1; 
        result=$(sh ./fio_result.sh logs/numjobs.${rw}_${bs}/${numjobs}.log);
        echo -e $numjobs'\t'$result;
    done
}

function iodepth() { 
    rw=$1
    bs=$2
    mkdir -p logs/iodepth.${rw}_${bs}
    sed -i "s/^rw=.*/rw=${rw}/" iodepth.conf
    sed -i "s/^bs=.*/bs=${bs}/" iodepth.conf

    echo ${rw}_${bs}
    echo -e iodepth"\t"iops"\t""bw(Mib/s)""\t""clat(usec)"

    for iodepth in 1 2 4 8 16 32 50 60 70 80 90 100 110 120;
    do
        sed -i "/^iodepth/c iodepth=${iodepth}" iodepth.conf;
        fio iodepth.conf > logs/iodepth.${rw}_${bs}/${iodepth}.log 2>&1; 
        result=$(sh ./fio_result.sh logs/iodepth.${rw}_${bs}/${iodepth}.log);
        echo -e $iodepth'\t'$result;
    done
}

function combo() { 
    rw=$1
    bs=$2
    mkdir -p logs/combo.${rw}_${bs}
    sed -i "s/^rw=.*/rw=${rw}/" combo.conf
    sed -i "s/^bs=.*/bs=${bs}/" combo.conf

    echo ${rw}_${bs}
    echo -e numjobs"\t"iodepth"\t"iops"\t""bw(Mib/s)""\t""clat(usec)"

    for numjobs in 2 4 8;
    do
        for iodepth in 4 8 16 32 64;
        do
            sed -i "/^numjobs/c numjobs=${numjobs}" combo.conf;
            sed -i "/^iodepth/c iodepth=${iodepth}" combo.conf;
            fio combo.conf > logs/combo.${rw}_${bs}/${numjobs}_${iodepth}.log 2>&1; 
            result=$(sh ./fio_result.sh logs/combo.${rw}_${bs}/${numjobs}_${iodepth}.log);
            echo -e $numjobs'\t'$iodepth'\t'$result;
        done
    done
}

function main() {
    type=$1
    if [ -z "$type" ]; then
        echo 'missing param [runtime|blocksize|numjobs|iodepth|combo]';
        return 0;
    fi
    if [ $type == "runtime" ]; then
        runtime randread 4k
        runtime randwrite 4k
        runtime read 1m
        runtime write 1m
    elif [ $type == "blocksize" ]; then
        blocksize randread
        blocksize randwrite
        blocksize read
        blocksize write
    elif [ $type == "numjobs" ]; then
        numjobs randread 4k
        numjobs randwrite 4k
        numjobs read 1m
        numjobs write 1m
    elif [ $type == "iodepth" ]; then
        iodepth randread 4k
        iodepth randwrite 4k
        iodepth read 1m
        iodepth write 1m
    elif [ $type == "combo" ]; then
        for bs in 64k 128k 256k 512k 1m;
        do
            combo randread $bs
            combo randwrite $bs
            combo read $bs
            combo write $bs
        done
    else
        echo 'invalid param'
    fi

    return 1
}

main $1
