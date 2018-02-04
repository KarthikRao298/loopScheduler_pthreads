#!/bin/sh

##static loop test

TEST1=$(./static_sched 1 0 10 10000 1 1 iteration 2> /dev/null)
if ./approx $TEST1 50;
then
    echo oktest1
else
    echo notok "./static_sched 1 0 10 10000 1 1 iteration" should give roughly "50"
    exit 1
fi

TEST2=$(./static_sched 1 0 10 10000 1 4 iteration 2> /dev/null)
if ./approx $TEST2 50;
then
    echo oktest2
else
    echo notok "./static_sched 1 0 10 10000 1 4 iteration" should give roughly "50"
    exit 1
fi

TEST3=$(./static_sched 1 0 10 10000 1 8 iteration 2> /dev/null)
if ./approx $TEST3 50;
then
    echo oktest3
else
    echo notok "./static_sched 1 0 10 10000 1 8 iteration" should give roughly "50"
    exit 1
fi

TEST4=$(./static_sched 1 0 10 10000 1 16 iteration 2> /dev/null)
if ./approx $TEST4 50;
then
    echo oktest4
else
    echo notok "./static_sched 1 0 10 10000 1 16 iteration" should give roughly "50"
    exit 1
fi

TEST5=$(./static_sched 1 0 10 10000 1 1 thread 2> /dev/null)
if ./approx $TEST5 50;
then
    echo oktest5
else
    echo notok "./static_sched 1 0 10 10000 1 1 thread" should give roughly "50"
    exit 1
fi

TEST6=$(./static_sched 1 0 10 10000 1 4 thread 2> /dev/null)
if ./approx $TEST6 50;
then
    echo oktest6
else
    echo notok "./static_sched 1 0 10 10000 1 4 thread" should give roughly "50"
    exit 1
fi

TEST7=$(./static_sched 1 0 10 10000 1 8 thread 2> /dev/null)
if ./approx $TEST7 50;
then
    echo oktest7
else
    echo notok "./static_sched 1 0 10 10000 1 8 thread" should give roughly "50"
    exit 1
fi

TEST8=$(./static_sched 1 0 10 10000 1 16 thread 2> /dev/null)
if ./approx $TEST8 50;
then
    echo oktest8
else
    echo notok "./static_sched 1 0 10 10000 1 16 thread" should give roughly "50"
    exit 1
fi

##dynamic loop test

TEST9=$(./dynamic_sched 1 0 10 10000 1 1 iteration 100 2> /dev/null)
if ./approx $TEST9 50;
then
    echo oktest9
else
    echo notok "./dynamic_sched 1 0 10 10000 1 1 iteration 100" should give roughly "50"
    exit 1
fi

TEST10=$(./dynamic_sched 1 0 10 10000 1 4 iteration 100 2> /dev/null)
if ./approx $TEST10 50;
then
    echo oktest10
else
    echo notok "./dynamic_sched 1 0 10 10000 1 4 iteration 100" should give roughly "50"
    exit 1
fi

TEST11=$(./dynamic_sched 1 0 10 10000 1 8 iteration 100 2> /dev/null)
if ./approx $TEST11 50;
then
    echo oktest11
else
    echo notok "./dynamic_sched 1 0 10 10000 1 8 iteration 100" should give roughly "50"
    exit 1
fi

TEST12=$(./dynamic_sched 1 0 10 10000 1 16 iteration 100 2> /dev/null)
if ./approx $TEST12 50;
then
    echo oktest12
else
    echo notok "./dynamic_sched 1 0 10 10000 1 16 iteration 100" should give roughly "50"
    exit 1
fi

TEST13=$(./dynamic_sched 1 0 10 10000 1 1 thread 100 2> /dev/null)
if ./approx $TEST13 50;
then
    echo oktest13
else
    echo notok "./dynamic_sched 1 0 10 10000 1 1 thread 100" should give roughly "50"
    exit 1
fi

TEST14=$(./dynamic_sched 1 0 10 10000 1 4 thread 100 2> /dev/null)
if ./approx $TEST14 50;
then
    echo oktest14
else
    echo notok "./dynamic_sched 1 0 10 10000 1 4 thread 100" should give roughly "50"
    exit 1
fi

TEST15=$(./dynamic_sched 1 0 10 10000 1 8 thread 100 2> /dev/null)
if ./approx $TEST15 50;
then
    echo oktest15
else
    echo notok "./dynamic_sched 1 0 10 10000 1 8 thread 100" should give roughly "50"
    exit 1
fi

TEST16=$(./dynamic_sched 1 0 10 10000 1 16 thread 100 2> /dev/null)
if ./approx $TEST16 50;
then
    echo oktest16
else
    echo notok "./dynamic_sched 1 0 10 10000 1 16 thread 100" should give roughly "50"
    exit 1
fi

TEST17=$(./dynamic_sched 1 0 10 10000 1 1 chunk 100 2> /dev/null)
if ./approx $TEST17 50;
then
    echo oktest17
else
    echo notok "./dynamic_sched 1 0 10 10000 1 1 chunk 100" should give roughly "50"
    exit 1
fi

TEST18=$(./dynamic_sched 1 0 10 10000 1 4 chunk 100 2> /dev/null)
if ./approx $TEST18 50;
then
    echo oktest18
else
    echo notok "./dynamic_sched 1 0 10 10000 1 4 chunk 100" should give roughly "50"
    exit 1
fi

TEST19=$(./dynamic_sched 1 0 10 10000 1 8 chunk 100 2> /dev/null)
if ./approx $TEST19 50;
then
    echo oktest19
else
    echo notok "./dynamic_sched 1 0 10 10000 1 8 chunk 100" should give roughly "50"
    exit 1
fi

TEST20=$(./dynamic_sched 1 0 10 10000 1 16 chunk 7 2> /dev/null)
if ./approx $TEST20 50;
then
    echo oktest20
else
    echo notok "./dynamic_sched 1 0 10 10000 1 16 chunk 7" should give roughly "50"
    exit 1
fi

