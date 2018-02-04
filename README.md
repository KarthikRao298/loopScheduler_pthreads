# 1. Static loop scheduler

A static loop scheduler is the simplest way to achieve some parallelism. It is used here to make the numerical integration problem parallel. Essentially, with T threads, each thread will do exactly 1 of the loop iterations. So that if the loop has 100 iterations and there are four threads, the first threas will execute loop iterations from 0 to 24, the second will execute iterations from 25 to 49 and so on.

The a static loop scheduler computes numerical integration. It outputs the integral value on stdout and the time it takes for the computation on stderr.
The program takes the following command line parameters: 
- functionid,  an integer to know which function to integrate
- a, the lower bound of the integral
- b, the upper bound of the integral
- n, an integer which is the number of points to compute the approximation of the integral
- intensity, an integer which is the second parameter to give the the function to integrate
- nbthreads, an integer indicating the number of threads that should perform the numerical integration
- sync, a string, either iteration or thread that indicate which synchronization method to use. iteration-level mutual exclusion essentially puts the mutual exclusion on each access to the variable. thread-level mutual exclusion makes each threads locally compute the sum of values in its own variable, and only aggregates the value into the results once all the iterations have been computed.

# 2. Dynamic loop scheduler

A dynamic loop schedulers are essentially managed by distributing ranges of indices to threads when they request them. The code outputs the integral value on stdout and the time it takes for the computation on stderr.
The program takes the following command line parameters: 
- functionid,  an integer to know which function to integrate
- a, the lower bound of the integral
- b, the upper bound of the integral
- n, an integer which is the number of points to compute the approximation of the integral
- intensity, an integer which is the second parameter to give the the function to integrate
- nbthreads, an integer indicating the number of threads that should perform the numerical integration
- sync, a string, either iteration or thread that indicate which synchronization method to use. iteration-level mutual exclusion essentially puts the mutual exclusion on each access to the variable. thread-level mutual exclusion makes each threads locally compute the sum of values in its own variable, and only aggregates the value into the results once all the iterations have been computed. chunk-level, puts the mutual exclusion once per chunk of loop computation
- granularity, an integer indicating how many iterations does one thread take at a time.


