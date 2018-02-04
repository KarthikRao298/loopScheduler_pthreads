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

#making the data

for intensity in $INTENSITIES;
do
    for n in $NS;
    do
	for thread in ${THREADS};
	do
	    for sync in iteration thread;
	    do
		./static_sched 1 0 10 ${n} ${intensity} ${thread} ${sync} 2>${RESULTDIR}/static_${n}_${intensity}_${thread}_${sync}  >/dev/null
	    done
	done 
    done
done

#preparing files for plotting

for intensity in $INTENSITIES;
do
    for n in $NSPLOT;
    do
	for sync in iteration thread;
	do
	    for thread in ${THREADS};
	    do
		#output in format "thread seqtime partime"
		echo ${thread} \
		     $(cat ${RESULTDIR}/sequential_${n}_${intensity}) \
		     $(cat ${RESULTDIR}/static_${n}_${intensity}_${thread}_${sync})
	    done > ${RESULTDIR}/speedup_static_${n}_${intensity}_${sync}
	done
    done
done

for thread in ${THREADS};
do
    for n in $NSPLOT;
    do
	for sync in iteration thread;
	do
	    for intensity in ${INTENSITIES};
	    do
		#output in format "intensity seqtime partime"
		echo ${intensity} \
		     $(cat ${RESULTDIR}/sequential_${n}_${intensity}) \
		     $(cat ${RESULTDIR}/static_${n}_${intensity}_${thread}_${sync})
	    done > ${RESULTDIR}/speedupi_static_${n}_${thread}_${sync}
	done
    done
done


for intensity in $INTENSITIES;
do
    for thread in ${THREADS};
    do
	for sync in iteration thread;
	do
	    for n in $NS;
	    do
		#output in format "n seqtime partime"
		echo ${n} \
		     $(cat ${RESULTDIR}/sequential_${n}_${intensity}) \
		     $(cat ${RESULTDIR}/static_${n}_${intensity}_${thread}_${sync})
	    done > ${RESULTDIR}/speedupn_static_${thread}_${intensity}_${sync}
	done
    done
done


#Speedup plots

for intensity in $INTENSITIES;
do
    for n in $NSPLOT;
    do
	GCMDSP="${GCMDSP} ; set key top left; \
                            set xlabel 'threads'; \
                            set ylabel 'speedup'; \
                            set xrange [*:20]; \
                            set yrange [0:20]; \
                            set title'n=$n intensity=$intensity'; \
                plot '${RESULTDIR}/speedup_static_${n}_${intensity}_iteration' u 1:(\$2/\$3) t 'iteration' lc 1, \
                     '${RESULTDIR}/speedup_static_${n}_${intensity}_thread' u 1:(\$2/\$3) lc 3 t 'thread'; "
    done
done

for intensity in $INTENSITIES;
do
    for thread in ${THREADS};
    do
	GCMDSPN="${GCMDSPN} ; set key top left; \
                            set xlabel 'n'; \
                            set ylabel 'speedup'; \
                            set xrange [*:*]; \
                            set yrange [0:20]; \
                            set title'thread=${thread} intensity=${intensity}'; \
                plot '${RESULTDIR}/speedupn_static_${thread}_${intensity}_iteration' u 1:(\$2/\$3) t 'iteration' lc 1, \
                     '${RESULTDIR}/speedupn_static_${thread}_${intensity}_thread' u 1:(\$2/\$3) lc 3 t 'thread'; "
    done
done

for n in $NSPLOT;
do
    for thread in ${THREADS};
    do
	GCMDSPI="${GCMDSPI} ; set key top left; \
                            set xlabel 'intensity'; \
                            set ylabel 'speedup'; \
                            set xrange [*:*]; \
                            set yrange [0:20]; \
                            set title'thread=${thread} intensity=${intensity}'; \
                plot '${RESULTDIR}/speedupi_static_${n}_${thread}_iteration' u 1:(\$2/\$3) t 'iteration' lc 1, \
                     '${RESULTDIR}/speedupi_static_${n}_${thread}_thread' u 1:(\$2/\$3) lc 3 t 'thread'; "
    done
done


#time as a function of thread plots

for intensity in $INTENSITIES;
do
    for n in $NSPLOT;
    do
	GCMDTIME="${GCMDTIME} ; set key top right; \
                            set xlabel 'threads'; \
                            set ylabel 'time (in seconds)'; \
                            set xrange [1:20]; \
                            set yrange [*:*]; \
                            set title'n=$n intensity=$intensity'; \
                plot '${RESULTDIR}/speedup_static_${n}_${intensity}_iteration' u 1:3 t 'iteration' lc 1, \
                     '${RESULTDIR}/speedup_static_${n}_${intensity}_thread' u 1:3 lc 3 t 'thread'; "
    done
done

#speedup as a function of n



gnuplot <<EOF
set terminal pdf
set output 'static_sched_plots.pdf'

set style data linespoints


${GCMDSP}

${GCMDSPN}

${GCMDSPI}

${GCMDTIME}

EOF
