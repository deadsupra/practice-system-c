ARCH := $(shell getconf LONG_BIT)

CC = gcc
CXX = g++
CFLAGS = -I.
CXXFLAGS = -c -Wall -I.

OUT = output
DEPS = -I. -I${SYSTEMC_HOME}/include -L. -L${SYSTEMC_HOME}/lib-linux64 -Wl,-rpath=${SYSTEMC_HOME}/lib-linux64

test:
	echo $(ARCH)

all: main
	./$(OUT)

install:

clean:
	rm *.o $(OUT)

main: main.o
	$(CXX) -c main.o -o $(OUT)

main.o: 
	$(CXX) $(DEPS) -o main.o main.cpp -lsystemc -lm