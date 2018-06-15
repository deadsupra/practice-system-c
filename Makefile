ARCH := $(shell getconf LONG_BIT)

CC = gcc
CXX = g++
CFLAGS = -I.
CXXFLAGS = -c -Wall -I.

OUT = output
DEPS = -I. -I${SYSTEMC_HOME}/include -L. -L${SYSTEMC_HOME}/lib-linux64 -Wl,-rpath=${SYSTEMC_HOME}/lib-linux64

all: main
	./$(OUT)

install:

clean:
	rm *.o $(OUT)

main: main.o
	$(CXX) -o $(OUT) main.o

main.o: main.cpp
	$(CXX) $(DEPS) -o main.o main.cpp -lsystemc -lm