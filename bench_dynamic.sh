#!/bin/sh

##TODO This assumes that sequential was run first

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

#GRANS="1 10 100 1000 10000 100000 1000000"
GRANS="1 100 10000 1000000"

#SYNCS="iteration thread chunk"
SYNCS="thread chunk"

NSPLOT="1 10 100 1000 10000 100000 1000000 10000000 100000000"
NS="${NSPLOT}" #no need to do more ns for this plot

#making the data

for intensity in $INTENSITIES;
do
    for n in $NS;
    do
	for thread in ${THREADS};
	do
	    for sync in ${SYNCS};
	    do
		for gran in $GRANS;
		do
		    ./dynamic_sched 1 0 10 ${n} ${intensity} ${thread} ${sync} ${gran} 2>${RESULTDIR}/dynamic_${n}_${intensity}_${thread}_${sync}_${gran}  >/dev/null
		done
	    done
	done 
    done
done

#preparing files for plotting

for intensity in $INTENSITIES;
do
    for thread in ${THREADS};
    do
	for n in $NSPLOT;
	do
	    for sync in ${SYNCS};
	    do
		for gran in ${GRANS};
		do
		    #output in format "gran seqtime partime"
		    echo ${gran} \
			 $(cat ${RESULTDIR}/sequential_${n}_${intensity}) \
			 $(cat ${RESULTDIR}/dynamic_${n}_${intensity}_${thread}_${sync}_${gran})
		done > ${RESULTDIR}/speedupc_dynamic_${n}_${thread}_${intensity}_${sync}
	    done
	done
    done
done


for intensity in $INTENSITIES;
do
    for gran in ${GRANS};
    do
	for n in $NSPLOT;
	do
	    for sync in ${SYNCS};
	    do
		for thread in ${THREADS};
		do
		    #output in format "gran seqtime partime"
		    echo ${thread} \
			 $(cat ${RESULTDIR}/sequential_${n}_${intensity}) \
			 $(cat ${RESULTDIR}/dynamic_${n}_${intensity}_${thread}_${sync}_${gran})
		done > ${RESULTDIR}/speedupt_dynamic_${n}_${intensity}_${sync}_${gran}
	    done
	done
    done
done

#Speedup plots

for intensity in $INTENSITIES;
do
    for n in $NSPLOT;
    do
	for thread in ${THREADS};
	do
	    # GCMDSP="${GCMDSP} ; set key top left; \
            #                   set xlabel 'granularity'; \
            #                   set ylabel 'speedup'; \
            #                   set xrange [*:*]; \
            #                   set yrange [*:20]; \
            #                   set title'n=$n intensity=$intensity thread=${thread}'; \
            #         plot '${RESULTDIR}/speedupc_dynamic_${n}_${thread}_${intensity}_iteration' u 1:(\$2/\$3) t 'iteration' lc 1, \
            #              '${RESULTDIR}/speedupc_dynamic_${n}_${thread}_${intensity}_chunk' u 1:(\$2/\$3) t 'chunk' lc 4, \
            #              '${RESULTDIR}/speedupc_dynamic_${n}_${thread}_${intensity}_thread' u 1:(\$2/\$3) lc 3 t 'thread'; "

	    GCMDSP="${GCMDSP} ; set key top left; \
                              set xlabel 'granularity'; \
                              set ylabel 'speedup'; \
                              set xrange [*:*]; \
                              set yrange [*:20]; \
                              set title'n=$n intensity=$intensity thread=${thread}'; \
                    plot '${RESULTDIR}/speedupc_dynamic_${n}_${thread}_${intensity}_chunk' u 1:(\$2/\$3) t 'chunk' lc 4, \
                         '${RESULTDIR}/speedupc_dynamic_${n}_${thread}_${intensity}_thread' u 1:(\$2/\$3) lc 3 t 'thread'; "

	done
    done
done

for intensity in $INTENSITIES;
do
    for n in $NSPLOT;
    do
	for gran in ${GRANS};
	do
	    # GCMDSPN="${GCMDSPN} ; set key top left; \
            #                       set xlabel 'threads'; \
            #                       set ylabel 'speedup'; \
            #                       set xrange [*:*]; \
            #                       set yrange [*:20]; \
            #                       set title 'thread=${thread} intensity=${intensity} granularity=${gran}'; \
            #     plot '${RESULTDIR}/speedupt_dynamic_${n}_${intensity}_iteration_${gran}' u 1:(\$2/\$3) t 'iteration' lc 1, \
            #          '${RESULTDIR}/speedupt_dynamic_${n}_${intensity}_chunk_${gran}' u 1:(\$2/\$3) t 'chunk' lc 4, \
            #          '${RESULTDIR}/speedupt_dynamic_${n}_${intensity}_thread_${gran}' u 1:(\$2/\$3) lc 3 t 'thread'; "

	    GCMDSPN="${GCMDSPN} ; set key top left; \
                                  set xlabel 'threads'; \
                                  set ylabel 'speedup'; \
                                  set xrange [*:*]; \
                                  set yrange [*:20]; \
                                  set title 'thread=${thread} intensity=${intensity} granularity=${gran}'; \
                plot '${RESULTDIR}/speedupt_dynamic_${n}_${intensity}_chunk_${gran}' u 1:(\$2/\$3) t 'chunk' lc 4, \
                     '${RESULTDIR}/speedupt_dynamic_${n}_${intensity}_thread_${gran}' u 1:(\$2/\$3) lc 3 t 'thread'; "
	done
    done
done

#speedup as a function of n



gnuplot <<EOF
set terminal pdf
set output 'dynamic_sched_plots.pdf'

set style data linespoints


${GCMDSP}

${GCMDSPN}

EOF
