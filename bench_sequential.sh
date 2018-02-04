#!/bin/sh

RESULTDIR=result/
h=`hostname`

if [ "$h" = "mba-i1.uncc.edu"  ];
then
    echo Do not run this on the headnode of the cluster, use qsub!
    exit 1
fi

if [ ! -d ${RESULTDIR} ];
then
    mkdir ${RESULTDIR}
fi
    

INTENSITIES="1 10 100 1000"
NS="`seq 1 10` `seq 20 20 100` `seq 200 200 1000` `seq 2000 2000 10000` `seq 20000 20000 100000` `seq 200000 200000 1000000` `seq 2000000 2000000 10000000` `seq 20000000 20000000 100000000`"
#NS="`seq 1 10`"
THREADS="1 2 4 8 12 16"

NSPLOT="1 10 100 1000 10000 100000 1000000 10000000 100000000"


for intensity in $INTENSITIES;
do
    for n in $NS;
    do
	./sequential 1 0 10 ${n} ${intensity} 2>${RESULTDIR}/sequential_${n}_${intensity}  >/dev/null
    done
done
