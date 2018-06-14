CC = g++
CFLAGS =
DEPS = -I. -I${SYSTEMC_HOME}/include -L. -L${SYSTEMC_HOME}/lib-linux64 -Wl,-rpath=${SYSTEMC_HOME}/lib-linux64

all: main
	./main

main:
	$(CC) $(DEPS) -o main main.cpp -lsystemc -lm

clean:
	rm *.o main
