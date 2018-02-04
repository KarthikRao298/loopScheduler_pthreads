CFLAGS=-O3 -std=c11
CXXFLAGS=-O3 -std=c++11 -g
LDFLAGS=-lpthread
ARCHIVES=libfunctions.a
LD=g++

all: static_sched

static_sched: static_sched.o
	$(LD) $(LDFLAGS) static_sched.o $(ARCHIVES) -o static_sched

dynamic_sched: dynamic_sched.o
	$(LD) $(LDFLAGS) dynamic_sched.o $(ARCHIVES) -o dynamic_sched

libfunctions.a: functions.o
	ar rcs libfunctions.a functions.o

libintegrate.a: sequential_lib.o
	ar rcs libintegrate.a sequential_lib.o

sequential: sequential.o 
	$(LD) $(LDFLAGS) sequential.o  libintegrate.a $(ARCHIVES) -o sequential

test: static_sched dynamic_sched approx
	./test.sh

static_sched_plots.pdf: static_sched sequential
	./bench_static.sh

dynamic_sched_plots.pdf: dynamic_sched sequential
	./bench_dynamic.sh

bench: static_sched_plots.pdf dynamic_sched_plots.pdf


assignment-pthreads.tgz: static_sched.cpp dynamic_sched.cpp approx.cpp Makefile bench_static.sh bench_dynamic.sh test.sh assignment-pthreads.pdf libfunctions.a libintegrate.a sequential.cpp bench_sequential.sh
	tar zcvf assignment-pthreads.tgz static_sched.cpp dynamic_sched.cpp approx.cpp Makefile bench_static.sh bench_dynamic.sh test.sh assignment-pthreads.pdf libfunctions.a libintegrate.a sequential.cpp bench_sequential.sh
